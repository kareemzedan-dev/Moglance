import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../../../core/utils/colors_manger.dart';
import '../../../../config/l10n/app_localizations.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../shared/presentation/views/widgets/message_bubble.dart';
import '../../domain/entities/message_entity.dart';
import '../manager/mark_message_as_read_view_model/mark_message_as_read_view_model.dart';
import '../manager/messages_view_model/messages_view_model.dart';
import '../manager/messages_view_model/messages_view_model_states.dart';
import '../manager/send_message_view_model/send_message_view_model.dart';
import '../manager/send_message_view_model/send_message_view_model_states.dart';
import 'chat_input_field.dart';
import '../../../../../../../../../features/attachments/domain/entities/attachment_entity/attaachments_entity.dart';

class ChatViewBody extends StatefulWidget {
  final String currentUserId;
  final String receiverId;
  final String currentUserRole;
  final String receiverUserRole;
  final String orderId;
  final String currentUserAvatar;
  final String receiverAvatar;
  final String currentUserName;
  final String receiverName;

  const ChatViewBody({
    super.key,
    required this.currentUserId,
    required this.receiverId,
    required this.currentUserRole,
    required this.receiverUserRole,
    required this.orderId,
    required this.currentUserAvatar,
    required this.receiverAvatar,
    required this.currentUserName,
    required this.receiverName,
  });

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final ScrollController _scrollController = ScrollController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlayingUrl;
  final markVM = getIt<MarkMessageAsReadViewModel>();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {

      markVM.markMessagesAsRead(widget.orderId, widget.currentUserId);
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _currentlyPlayingUrl = null;
      });
    });
  }

  @override
  void dispose() {
    markVM.close();
    _scrollController.dispose();
    _audioPlayer.dispose();
    super.dispose();

  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildAttachmentWidget(
      AttachmentEntity att, bool isCurrentUser, String messageId,
      {bool isTemporary = false}) {
    final isImage = att.type.startsWith("image/");
    final isPDF = att.type == "application/pdf";
    final isAudio =
        att.type.startsWith("audio/") || att.type == "application/octet-stream";

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          width: 250,
          decoration: BoxDecoration(
            color: isCurrentUser
                ? Colors.blue.withOpacity(isTemporary ? 0.03 : 0.05)
                : Colors.green.withOpacity(isTemporary ? 0.03 : 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isCurrentUser
                  ? Colors.blue.withOpacity(isTemporary ? 0.1 : 0.2)
                  : Colors.green.withOpacity(isTemporary ? 0.1 : 0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isCurrentUser ? Colors.blue : Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isImage
                      ? Icons.image
                      : isPDF
                      ? Icons.picture_as_pdf
                      : Icons.audiotrack,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: !isAudio
                      ? () {
                    if (isImage) {
                      showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: const EdgeInsets.all(20),
                          child: Stack(
                            children: [
                              InteractiveViewer(
                                child: Image.network(
                                  att.url,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: IconButton(
                                  icon: const Icon(Icons.close,
                                     ),
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (isPDF) {
                      launchUrl(Uri.parse(att.url));
                    }
                  }
                      : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        att.name ?? "Attachment",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isImage
                            ? "Image"
                            : isPDF
                            ? "PDF Document"
                            : "Audio File",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isAudio)
                IconButton(
                  icon: Icon(
                    _currentlyPlayingUrl == att.url
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    color: Colors.orange,
                    size: 28,
                  ),
                  onPressed: () async {
                    if (_currentlyPlayingUrl == att.url) {
                      await _audioPlayer.pause();
                      setState(() => _currentlyPlayingUrl = null);
                    } else {
                      await _audioPlayer.stop();
                      await _audioPlayer.play(UrlSource(att.url));
                      setState(() => _currentlyPlayingUrl = att.url);
                    }
                  },
                ),
            ],
          ),
        ),
        if (isTemporary)
          Positioned(
            top: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isCurrentUser ? Colors.blue : Colors.green,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildMessageContent(
      MessageEntity msg, bool isCurrentUser, bool isTemporary) {
    final widgets = <Widget>[];

    if (isTemporary) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isCurrentUser ? Colors.blue : Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Sending...",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    final localTime = msg.createdAt.toLocal();
    final hour = localTime.hour == 0
        ? 12
        : localTime.hour > 12
        ? localTime.hour - 12
        : localTime.hour;
    final minute = localTime.minute.toString().padLeft(2, '0');
    final period = localTime.hour >= 12 ? 'PM' : 'AM';


    if (msg.messageType == "text" && (msg.content?.isNotEmpty ?? false)) {
      widgets.add(
          MessageBubble(
            isSent: msg.senderId == widget.currentUserId,
            seenAt: msg.seenAt,
            userName: isCurrentUser ? widget.currentUserName : widget.receiverName,
            sender: isCurrentUser ? SenderType.freelancer : SenderType.client,
            message: msg.content ?? "",
            avatarUrl: isCurrentUser ? widget.currentUserAvatar : widget.receiverAvatar,
            chatWithUsers: true,
            time: "$hour:$minute $period",
          )

      );
    }

    if (msg.attachment != null && msg.attachment!.isNotEmpty) {
      final attachments = msg.attachment!
          .map((att) => _buildAttachmentWidget(att, isCurrentUser, msg.id!,
          isTemporary: isTemporary))
          .toList();

      widgets.add(
        Column(
          crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: attachments,
        ),
      );
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final vm = getIt<MessagesViewModel>();
            vm.loadAndSubscribeMessages(widget.orderId, widget.currentUserId, widget.receiverId);
            return vm;
          },
        ),
        BlocProvider(
          create: (_) => getIt<SendMessageViewModel>(),
        ),
      ],
      child: Column(
        children: [
          Expanded(
            child: MultiBlocListener(
              listeners: [
                BlocListener<SendMessageViewModel, SendMessageViewModelStates>(
                  listener: (context, state) {
                    if (state is SendMessageViewModelStatesError) {
                      final errorMessage = state.failure ?? state.failure.toString();

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    } else if (state is SendMessageViewModelStatesSuccess) {
                      _scrollToBottom();
                    }
                  },
                ),

                BlocListener<MessagesViewModel, MessagesStates>(
                  listener: (context, state) {
                    if (state is MessagesSuccess) {
                      if (state.messages.any((msg) => msg.senderId != widget.currentUserId && msg.seenAt == null)) {
                        markVM.markMessagesAsRead(widget.orderId, widget.currentUserId);
                      }

                      _scrollToBottom();
                    }
                  },
                ),
              ],
              child: BlocBuilder<MessagesViewModel, MessagesStates>(
                builder: (context, state) {
                  if (state is MessagesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MessagesError) {
                    return Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/lotties/no_internet.json', width: 200, height: 200),
                        const SizedBox(height: 20),
                        Text("تحقق من اتصالك بالانترنت"),
                      ],
                    ));
                  } else if (state is MessagesSuccess) {
                    final messages = state.messages;

                    final tempMessages = context.select<
                        SendMessageViewModel, List<MessageEntity>>(
                          (vm) => vm.temporaryMessages,
                    );

                    final allMessages = [...messages, ...tempMessages];
                    allMessages.sort(
                            (a, b) => a.createdAt.compareTo(b.createdAt));

                    if (allMessages.isEmpty) {
                      return   Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(Assets.assetsNoMessages,
                              width: 250.w,
                              height: 250.h,
                              fit: BoxFit.contain,),
                              SizedBox(height: 16.h),
                              Text(
                              "لا يوجد رسائل بعد",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: allMessages.length,
                      itemBuilder: (context, index) {
                        final msg = allMessages[index];
                        final isCurrentUser =
                            msg.senderId == widget.currentUserId;
                        final isTemporary = tempMessages
                            .any((m) => m.id == msg.id);

                        return Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          child: Column(
                            crossAxisAlignment: isCurrentUser
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: _buildMessageContent(
                                msg, isCurrentUser, isTemporary),
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          ChatInputField(
            orderId: widget.orderId,
            currentUserId: widget.currentUserId,
            receiverId: widget.receiverId,
            currentUserRole: widget.currentUserRole,
            receiverUserRole: widget.receiverUserRole,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
