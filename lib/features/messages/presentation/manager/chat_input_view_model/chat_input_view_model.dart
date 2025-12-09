// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:record/record.dart';
// import 'package:uuid/uuid.dart';
// import '../../../../attachments/data/models/attachments_dm/attachments_dm.dart';
// import '../../../../attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model.dart';
// import '../../../../attachments/presentation/manager/upload_attachments_view_model/upload_attachments_view_model_states.dart';
// import '../../../domain/entities/message_entity.dart';
// import '../send_message_view_model/send_message_view_model.dart';
//
// @singleton
// class ChatInputViewModel extends ChangeNotifier {
//   final TextEditingController textController = TextEditingController();
//   final audioRecorder = AudioRecorder();
//
//   bool _isTyping = false;
//   bool _isSending = false;
//   bool _isRecording = false;
//
//   final List<AttachmentModel> _pendingAttachments = [];
//
//   bool get isTyping => _isTyping;
//
//   set isTyping(bool value) {
//     if (_isTyping != value) {
//       _isTyping = value;
//       notifyListeners(); // ده بيخلي الواجهة تتحدث أوتوماتيكي
//     }
//   }
//   bool get isSending => _isSending;
//   bool get isRecording => _isRecording;
//   List<AttachmentModel> get pendingAttachments => _pendingAttachments;
//
//   @override
//   void dispose() {
//     textController.dispose();
//     super.dispose();
//   }
//
//   void updateSending(bool sending) {
//     _isSending = sending;
//     notifyListeners();
//   }
//
//   void updateRecording(bool recording) {
//     _isRecording = recording;
//     notifyListeners();
//   }
//
//   void addPendingAttachment(AttachmentModel attachment) {
//     _pendingAttachments.add(attachment);
//     notifyListeners();
//   }
//
//   void removePendingAttachment(AttachmentModel attachment) {
//     _pendingAttachments.remove(attachment);
//     notifyListeners();
//   }
//
//   void clearPendingAttachments() {
//     _pendingAttachments.clear();
//     notifyListeners();
//   }
//
//   // ======================= TEXT MESSAGE =======================
//   void sendTextMessage({
//     required BuildContext context,
//     required String? orderId,
//     required String currentUserId,
//     required String receiverId,
//     required String senderType,
//     required String receiverType,
//     VoidCallback? onMessageSent,
//     VoidCallback? onSuccess,
//     VoidCallback? onError,
//   }) {
//     final text = textController.text.trim();
//     if (text.isEmpty || _isSending) return;
//
//     _isSending = true;
//     notifyListeners();
//
//     final message = MessageEntity(
//       id: const Uuid().v4(),
//       orderId: orderId,
//       senderId: currentUserId,
//       receiverId: receiverId,
//       paymentId: null,
//       messageType: "text",
//       content: text,
//       attachment: null,
//       status: "sent",
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//       senderType: senderType,
//       receiverType: receiverType,
//     );
//
//     context.read<SendMessageViewModel>().sendMessage(message, orderId:  orderId! ).then((_) {
//       textController.clear();
//       _isTyping = false;
//       _isSending = false;
//       notifyListeners();
//       onMessageSent?.call();
//       onSuccess?.call();
//     }).catchError((error) {
//       _isSending = false;
//       notifyListeners();
//       onError?.call();
//     });
//   }
//
//   // ======================= UPLOAD ATTACHMENTS =======================
//   Future<void> uploadAttachments({
//     required List<AttachmentModel> attachments,
//     required BuildContext context,
//     required Function(String, bool) onUploadStatusChanged,
//   }) async {
//     final uploadVM = context.read<UploadAttachmentsViewModel>();
//
//     for (final attachment in attachments) {
//       final file = File(attachment.storagePath ?? '');
//       if (!await file.exists()) continue;
//
//       try {
//         onUploadStatusChanged(attachment.id!, true);
//
//         uploadVM.files.clear();
//         uploadVM.files.add(file);
//         uploadVM.generateFileKey(file);
//
//         final completer = Completer<void>();
//         late final StreamSubscription sub;
//
//         sub = uploadVM.stream.listen((state) {
//           if (state is UploadAttachmentsViewModelStatesSuccess) {
//             completer.complete();
//             sub.cancel();
//           } else if (state is UploadAttachmentsViewModelStatesError) {
//             completer.completeError(state.message);
//             sub.cancel();
//           }
//         });
//
//         await uploadVM.uploadAttachments(bucketName: "attachments");
//         await completer.future.timeout(const Duration(minutes: 2));
//
//         if (uploadVM.state is UploadAttachmentsViewModelStatesSuccess) {
//           final uploadedAttachment = (uploadVM.state as UploadAttachmentsViewModelStatesSuccess)
//               .attachments
//               .first;
//
//           final updatedAttachment = attachment.copyWith(
//             url: uploadedAttachment.url,
//             storagePath: uploadedAttachment.storagePath,
//           );
//
//           addPendingAttachment(updatedAttachment);
//           onUploadStatusChanged(attachment.id!, false);
//         }
//       } catch (e) {
//         onUploadStatusChanged(attachment.id!, false);
//         print('🔥 Attachment upload error: $e');
//       }
//     }
//   }
//
//   // ======================= SEND PENDING ATTACHMENTS =======================
//   Future<void> sendPendingAttachments({
//     required BuildContext context,
//     required String? orderId,
//     required String currentUserId,
//     required String receiverId,
//     required String senderType,
//     required String receiverType,
//     VoidCallback? onMessageSent,
//     VoidCallback? onSuccess,
//     VoidCallback? onError,
//   }) async {
//     if (_pendingAttachments.isEmpty || _isSending) return;
//
//     _isSending = true;
//     notifyListeners();
//
//     try {
//       for (final attachment in List<AttachmentModel>.from(_pendingAttachments)) {
//         final attachmentType = attachment.type ?? "";
//         final type = attachmentType.startsWith("image/")
//             ? "image"
//             : attachmentType.startsWith("audio/")
//             ? "audio"
//             : "file";
//
//
//         final message = MessageEntity(
//           id: const Uuid().v4(),
//           orderId: orderId,
//           senderId: currentUserId,
//           receiverId: receiverId,
//           paymentId: null,
//           messageType: type,
//           content: null,
//           attachment: [attachment],
//           status: "sent",
//           createdAt: DateTime.now(),
//           updatedAt: DateTime.now(),
//           senderType: senderType,
//           receiverType: receiverType,
//         );
//
//         await context.read<SendMessageViewModel>().sendMessage(message, orderId:  orderId!);
//       }
//
//       clearPendingAttachments();
//       onMessageSent?.call();
//       onSuccess?.call();
//     } catch (e) {
//       onError?.call();
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("فشل في إرسال المرفقات: $e"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       _isSending = false;
//       notifyListeners();
//     }
//   }
//
//   // ======================= VOICE MESSAGE =======================
//   Future<void> startOrStopRecording({
//     required BuildContext context,
//     required String? orderId,
//     required String currentUserId,
//     required String receiverId,
//     required String senderType,
//     required String receiverType,
//     VoidCallback? onMessageSent,
//     VoidCallback? onRecordingStarted,
//     Function(String)? onRecordingStopped,
//     Function(String)? onUploadSuccess,
//     Function(String)? onUploadError,
//   }) async {
//     if (_isRecording) {
//       final path = await audioRecorder.stop();
//       _isRecording = false;
//       notifyListeners();
//
//       if (path != null) {
//         onRecordingStopped?.call(path);
//         await _uploadAndSendVoiceMessage(
//           context: context,
//           filePath: path,
//           orderId: orderId,
//           currentUserId: currentUserId,
//           receiverId: receiverId,
//           senderType: senderType,
//           receiverType: receiverType,
//           onMessageSent: onMessageSent,
//           onUploadSuccess: onUploadSuccess,
//           onUploadError: onUploadError,
//         );
//       }
//     } else {
//       final permission = await Permission.microphone.request();
//       if (!permission.isGranted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Microphone permission denied")),
//         );
//         return;
//       }
//
//       final dir = await getTemporaryDirectory();
//       final filePath = "${dir.path}/record_${DateTime.now().millisecondsSinceEpoch}.m4a";
//
//       await audioRecorder.start(
//           path: filePath,
//         RecordConfig(
//
//         encoder: AudioEncoder.aacLc,
//         bitRate: 128000,
//         sampleRate: 44100,
//         numChannels: 2,
//         autoGain: false,
//         echoCancel: true,
//         noiseSuppress: true,
//         )
//       );
//
//       _isRecording = true;
//       notifyListeners();
//       onRecordingStarted?.call();
//     }
//   }
//
//   Future<void> _uploadAndSendVoiceMessage({
//     required BuildContext context,
//     required String filePath,
//     required String? orderId,
//     required String currentUserId,
//     required String receiverId,
//     required String senderType,
//     required String receiverType,
//     VoidCallback? onMessageSent,
//     Function(String)? onUploadSuccess,
//     Function(String)? onUploadError,
//   }) async {
//     _isSending = true;
//     notifyListeners();
//
//     final messageId = 'voice_${DateTime.now().millisecondsSinceEpoch}';
//     final uploadVM = context.read<UploadAttachmentsViewModel>();
//     final file = File(filePath);
//
//     try {
//       uploadVM.files.clear();
//       uploadVM.files.add(file);
//       uploadVM.generateFileKey(file);
//
//       final completer = Completer<void>();
//       late final StreamSubscription sub;
//
//       sub = uploadVM.stream.listen((state) {
//         if (state is UploadAttachmentsViewModelStatesSuccess) {
//           completer.complete();
//           sub.cancel();
//         } else if (state is UploadAttachmentsViewModelStatesError) {
//           completer.completeError('Upload failed');
//           sub.cancel();
//         }
//       });
//
//       await uploadVM.uploadAttachments(bucketName: "attachments");
//       await completer.future.timeout(const Duration(minutes: 2));
//
//       if (uploadVM.state is UploadAttachmentsViewModelStatesSuccess) {
//         final attachments = (uploadVM.state as UploadAttachmentsViewModelStatesSuccess)
//             .attachments
//             .map((e) => AttachmentModel.fromEntity(e))
//             .toList();
//
//         final message = MessageEntity(
//           id: const Uuid().v4(),
//           orderId: orderId,
//           senderId: currentUserId,
//           receiverId: receiverId,
//           paymentId: null,
//           messageType: "audio",
//           content: null,
//           attachment: attachments,
//           status: "sent",
//           createdAt: DateTime.now(),
//           updatedAt: DateTime.now(),
//           senderType: senderType,
//           receiverType: receiverType,
//         );
//
//         await context.read<SendMessageViewModel>().sendMessage(message, orderId:  orderId!);
//         onMessageSent?.call();
//         onUploadSuccess?.call(messageId);
//       }
//     } catch (e) {
//       onUploadError?.call(messageId);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("فشل في رفع الرسالة الصوتية: $e"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       _isSending = false;
//       notifyListeners();
//     }
//   }
//
//   @override
//   void dispose() {
//     textController.dispose();
//     audioRecorder.dispose();
//     super.dispose();
//   }
// }
