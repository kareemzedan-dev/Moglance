import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:record/record.dart';

import '../../../../../../../../../core/di/di.dart';
import '../../../attachments/data/models/attachments_dm/attachments_dm.dart';
import '../../../attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart';
import '../../../attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model_states.dart';
import '../../domain/entities/message_entity.dart';
import '../manager/send_message_view_model/send_message_view_model.dart';
import '../manager/send_message_view_model/send_message_view_model_states.dart';

class ChatInputField extends StatefulWidget {
  final String? orderId;
  final String currentUserId;
  final String receiverId;
  final String currentUserRole;
  final String receiverUserRole;
  final VoidCallback? onMessageSent;

  const ChatInputField({
    super.key,
    this.orderId,
    required this.currentUserId,
    required this.receiverId,
    required this.currentUserRole,
    required this.receiverUserRole,
    this.onMessageSent,
  });

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late final SendMessageViewModel _sendVM;
  late final UploadAttachmentsViewModel _uploadVM;
  final AudioRecorder _audioRecorder = AudioRecorder();

  bool _isUploading = false;
  double _uploadProgress = 0.0;
  List<File> _uploadingFiles = [];
  bool _isTyping = false;
  bool _isSending = false;
  bool _isRecording = false;

  String get _senderType => widget.currentUserRole;
  String get _receiverType => widget.receiverUserRole;

  @override
  void initState() {
    super.initState();
    _sendVM = getIt<SendMessageViewModel>();
    _uploadVM = getIt<UploadAttachmentsViewModel>();

    _uploadVM.onFileUploadedSuccessfully = (attachments) {
      print("📤 Auto-sending message for uploaded files: ${attachments.length}");
      _handleAttachmentUpload(attachments);
    };

  }


  @override
  void dispose() {
    _resetUploadState();
    _controller.dispose();
    _focusNode.dispose();
    _sendVM.close();
    _uploadVM.close();
    _audioRecorder.dispose();
    super.dispose();
  }

  void _startUploading(File file) {
    if (!_uploadingFiles.contains(file)) {
      print('📤 Starting upload for file: ${file.path}');
      setState(() {
        _isUploading = true;
        _uploadingFiles.add(file);
        _uploadProgress = 0.0;
      });
    }
  }


  void _updateUploadProgress(double progress) {
    print('📊 Upload progress: ${(progress * 100).toStringAsFixed(0)}%');
    setState(() {
      _uploadProgress = progress;
    });
  }

  void _finishUploading(File file) {
    print('✅ Finished upload for file: ${file.path}');
    setState(() {
      _uploadingFiles.remove(file);
      if (_uploadingFiles.isEmpty) {
        _isUploading = false;
        _uploadProgress = 0.0;
        print('🎯 All uploads finished - hiding indicator');
      } else {
        print('📁 Still uploading ${_uploadingFiles.length} file(s)');
      }
    });
  }

  void _resetUploadState() {
    print('🔄 Resetting upload state');
    setState(() {
      _isUploading = false;
      _uploadProgress = 0.0;
      _uploadingFiles.clear();
    });
  }

  Future<void> _sendTextMessage(BuildContext context) async {
    final text = _controller.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() => _isSending = true);

    final message = MessageEntity(
      id: const Uuid().v4(),
      orderId: widget.orderId,
      senderId: widget.currentUserId,
      receiverId: widget.receiverId,
      paymentId: null,
      messageType: "text",
      content: text,
      attachment: null,
      status: "sent", // غير إلى "sent"
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      senderType: _senderType,
      receiverType: _receiverType,
    );

    _sendVM.sendMessage(message, orderId: widget.orderId);

    _controller.clear();
    setState(() {
      _isTyping = false;
      _isSending = false;
    });
    widget.onMessageSent?.call();
  }

  void _handleAttachmentUpload(List<AttachmentModel> attachments) {
    if (!mounted || attachments.isEmpty || _isSending) return;

    setState(() => _isSending = true);

    final first = attachments.first;
    final isImage = first.type.startsWith("image/");
    final isAudio = first.type.startsWith("audio/");
    final messageType = isImage ? "image" : isAudio ? "audio" : "file";

    final message = MessageEntity(
      id: const Uuid().v4(),
      orderId: widget.orderId,
      senderId: widget.currentUserId,
      receiverId: widget.receiverId,
      paymentId: null,
      messageType: messageType,
      content: null,
      attachment: attachments,
      status: "sent",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      senderType: _senderType,
      receiverType: _receiverType,
    );

    _sendVM.sendMessage(message, orderId: widget.orderId);

    if (!mounted) return; // ✅ تأكد تاني إن الودجت لسه موجود بعد الإرسال

    setState(() => _isSending = false);
    widget.onMessageSent?.call();
  }


  Future<void> _startOrStopRecording() async {
    if (_isRecording) {
      final path = await _audioRecorder.stop();
      if (path != null) {
        final file = File(path);
        setState(() => _isRecording = false);

        _uploadVM.files.add(file);
        _uploadVM.generateFileKey(file);

        _startUploading(file);

        // رفع الملف
        await _uploadVM.uploadSingleAttachment(
          file,
          bucketName: "attachments",
        );
      }
    } else {
      final permission = await Permission.microphone.request();
      if (!permission.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Microphone permission denied")),
        );
        return;
      }

      final dir = await getTemporaryDirectory();
      final filePath = "${dir.path}/record_${DateTime.now().millisecondsSinceEpoch}.m4a";

      await _audioRecorder.start(
        path: filePath,
        RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
      );

      setState(() => _isRecording = true);
    }
  }

  Widget _buildUploadingIndicator() {
    if (!_isUploading || _uploadingFiles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16.w,
            height: 16.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: _uploadProgress > 0 ? _uploadProgress : null,
              backgroundColor: Colors.blue.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Uploading ${_uploadingFiles.length} file(s)...",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue.shade800,
                  ),
                ),
                if (_uploadProgress > 0)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: LinearProgressIndicator(
                      value: _uploadProgress,
                      backgroundColor: Colors.blue.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                      minHeight: 2.h,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            "${(_uploadProgress * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            icon: Icon(Icons.close, size: 18.sp, color: Colors.blue.shade700),
            onPressed: () {
              print('🚫 Cancelling uploads for ${_uploadingFiles.length} file(s)');
              _resetUploadState();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: (v) => setState(() => _isTyping = v.trim().isNotEmpty),
        minLines: 1,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: "اكتب رسالتك...",

          hintStyle: TextStyle(color: Colors.grey.shade500),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }

  Widget _buildAttachmentButton() {
    return GestureDetector(
      onTap: () async {
        await _uploadVM.pickFilesFromDevice(
          bucketName: "attachments",
          singleFileMode: true,
        );
      },
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(
          Icons.attach_file,
          color: Colors.grey.shade600,
          size: 22.sp,
        ),
      ),
    );
  }

  Widget _buildSendOrRecordButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 44.w,
      height: 44.h,
      decoration: BoxDecoration(
        gradient: _isTyping && !_isSending
            ? const LinearGradient(
          colors: [Color(0xFF25D366), Color(0xFF128C7E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : null,
        color: !_isTyping
            ? (_isRecording ? Colors.redAccent : Colors.grey.shade300)
            : (_isSending ? Colors.grey.shade400 : null),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(22.r),
        onTap: _isTyping && !_isSending
            ? () => _sendTextMessage(context)
            : _startOrStopRecording,
        child: Center(
          child: _isSending
              ? SizedBox(
            width: 18.w,
            height: 18.h,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : Icon(
            _isTyping
                ? CupertinoIcons.paperplane_fill
                : (_isRecording
                ? CupertinoIcons.stop_fill
                : CupertinoIcons.mic_fill),
            color: _isTyping
                ? Colors.white
                : (_isRecording ? Colors.white : Colors.grey.shade600),
            size: 20.sp,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _sendVM),
        BlocProvider.value(value: _uploadVM),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildUploadingIndicator(),
          MultiBlocListener(
            listeners: [
              BlocListener<SendMessageViewModel, SendMessageViewModelStates>(
                listener: (context, state) {
                  if (state is SendMessageViewModelStatesError) {
                    setState(() => _isSending = false);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to send message: ${state.failure}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
              BlocListener<UploadAttachmentsViewModel, UploadAttachmentsViewModelStates>(
                listener: (context, state) {
                  print('📬 Upload state changed: ${state.runtimeType}');

                  if (state is UploadAttachmentsViewModelStatesLoading) {
                    print('⏳ Upload loading started');
                    setState(() {
                      _isUploading = true;
                      _uploadProgress = 0.0;
                    });
                  }

                  else if (state is UploadAttachmentsViewModelStatesUploading) {
                    _startUploading(state.file);
                    _updateUploadProgress(state.progress);
                  }

                  else if (state is UploadAttachmentsViewModelStatesSuccess) {
                    print('✅ Upload success for file: ${state.file.path}');
                    _finishUploading(state.file);


                    final attachments = state.attachments
                        .map((e) => AttachmentModel.fromEntity(e))
                        .toList();
                    _handleAttachmentUpload(attachments);
                  }

                  else if (state is UploadAttachmentsViewModelStatesError) {
                    print('❌ Upload error: ${state.message}');
                    _finishUploading(state.file ?? File(""));

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Upload failed: ${state.message}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  else if (state is UploadAttachmentsViewModelStatesInitial) {
                    print('🔄 Upload state reset to initial');
                    _resetUploadState();
                  }
                },
              ),

            ],
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 10.h,
                left: 12.w,
                right: 12.w,
                top: 8.h,
              ),
              decoration: BoxDecoration(

                boxShadow: [
                  BoxShadow(
                    color: Colors.white ,
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _buildAttachmentButton(),
                  SizedBox(width: 8.w),
                  Expanded(child: _buildTextField()),
                  SizedBox(width: 8.w),
                  _buildSendOrRecordButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}