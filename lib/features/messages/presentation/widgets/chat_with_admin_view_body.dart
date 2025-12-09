import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../attachments/domain/entities/attachment_entity/attaachments_entity.dart';
import '../../../shared/presentation/views/widgets/message_bubble.dart';
import '../../domain/entities/message_entity.dart';
import '../manager/chat_with_admin_view_model/chat_with_admin_state.dart';
import '../manager/chat_with_admin_view_model/chat_with_admin_view_model.dart';
import 'admin_chat_input_field.dart';

class ChatWithAdminViewBody extends StatefulWidget {
  final String currentUserId;

  const ChatWithAdminViewBody({super.key, required this.currentUserId});

  @override
  State<ChatWithAdminViewBody> createState() => _ChatWithAdminViewBodyState();
}

class _ChatWithAdminViewBodyState extends State<ChatWithAdminViewBody> {
  final ScrollController _scrollController = ScrollController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentlyPlayingUrl;
  int _lastMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() => _currentlyPlayingUrl = null);
    });
  }

  @override
  void dispose() {
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

  Widget _buildAttachmentWidget(AttachmentEntity att, bool isCurrentUser) {
    final isImage = att.type.startsWith("image/");
    final isPDF = att.type == "application/pdf";
    final isAudio =
        att.type.startsWith("audio/") || att.type == "application/octet-stream";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      width: 250,
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Colors.blue.withOpacity(0.05)
            : Colors.green.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrentUser
              ? Colors.blue.withOpacity(0.2)
              : Colors.green.withOpacity(0.2),
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
              color: Colors.white,
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
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.error,
                                          color: Colors.red, size: 40),
                                      SizedBox(height: 8),
                                      Text(
                                        'Failed to load image',
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.white),
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
                  if (isAudio) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
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
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Tap to play",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMessageContent(MessageEntity msg, bool isCurrentUser) {
    final widgets = <Widget>[];

    // الرسالة النصية
    if (msg.messageType == "text" && (msg.content?.isNotEmpty ?? false)) {
      final hour = msg.createdAt.hour % 12 == 0 ? 12 : msg.createdAt.hour % 12;
      final period = msg.createdAt.hour >= 12 ? "PM" : "AM";

      widgets.add(
        MessageBubble(
          isSent: msg.seenAt != null,
          userName: isCurrentUser
              ? SharedPrefHelper.getString(StringsManager.fullNameKey)!
              : "Admin",
          sender: isCurrentUser ? SenderType.client : SenderType.admin,
          message: msg.content ?? "",
          time:
          "$hour:${msg.createdAt.minute.toString().padLeft(2, '0')} $period",
          chatWithUsers: true,
          avatarUrl: "",
        ),
      );
    }

    // المرفقات
    if (msg.attachment != null && msg.attachment!.isNotEmpty) {
      final attachments = msg.attachment!
          .map((att) => _buildAttachmentWidget(att, isCurrentUser))
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
    final vm = context.read<ChatWithAdminViewModel>();

    return Column(
      children: [
        Expanded(
          child: BlocConsumer<ChatWithAdminViewModel, ChatWithAdminStates>(
            listener: (context, state) {
              final messageCount = vm.messages.length;
              if (messageCount != _lastMessageCount) {
                _lastMessageCount = messageCount;
                _scrollToBottom();
              }
            },
            builder: (context, state) {
              if (state is ChatWithAdminLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ChatWithAdminError) {
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/lotties/no_internet.json', width: 200, height: 200),
                    const SizedBox(height: 20),
                    Text("تحقق من اتصالك بالانترنت"),
                  ],
                ));
              }

              final messages = vm.messages;

              // لو مفيش رسائل
              if (messages.isEmpty) {
                return ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    const MessageBubble(
                      message:
                      "💬 اترك رسالتك وسيتم التواصل معك خلال الساعات القادمة.",
                      time: "",
                      sender: SenderType.admin,
                      avatarUrl: "",
                      chatWithUsers: true,
                      userName: "Admin",
                      isSent: true,
                    ),
                    SizedBox(height: 24.h),
                    Image.asset(
                      Assets.assetsNoMessages,
                      width: 250.w,
                      height: 250.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      " لا يوجد رسائل بعد \n  لا تتردد في التواصل معنا الان",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              }

              // لو في رسائل
              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length + 1,
                itemBuilder: (context, index) {
                  // أول رسالة دايمًا الأدمن
                  if (index == 0) {
                    return const MessageBubble(
                      message:
                      "💬 اترك رسالتك وسيتم التواصل معك خلال الساعات القادمة.",
                      time: "",
                      sender: SenderType.admin,
                      avatarUrl: "",
                      chatWithUsers: true,
                      userName: "Admin",
                      isSent: true,
                    );
                  }

                  final msg = messages[index - 1];
                  final isCurrentUser = msg.senderId == widget.currentUserId;

                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    child: Column(
                      crossAxisAlignment: isCurrentUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: _buildMessageContent(msg, isCurrentUser),
                    ),
                  );
                },
              );
            },
          ),
        ),
        AdminChatInputField(
          currentUserId: widget.currentUserId,
          onMessageSent: _scrollToBottom,
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
