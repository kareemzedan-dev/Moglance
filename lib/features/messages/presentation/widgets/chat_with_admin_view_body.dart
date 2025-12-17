import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../../../../core/di/di.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../attachments/domain/entities/attachment_entity/attaachments_entity.dart';
import '../../../shared/presentation/views/widgets/message_bubble.dart';
import '../../domain/entities/message_entity.dart';
import '../manager/chat_with_admin_view_model/chat_with_admin_state.dart';
import '../manager/chat_with_admin_view_model/chat_with_admin_view_model.dart';
import '../manager/mark_admin_message_as_read_view_model/mark_admin_message_as_read_view_model.dart';
import '../manager/unread_messages_badge_view_model/unread_messages_badge_view_model.dart';
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
    Future.microtask(() {
      context
          .read<MarkAdminMessageAsReadViewModel>()
          .markAdminMessageAsRead(widget.currentUserId);
      context
          .read<UnreadMessagesBadgeViewModel>()
          .markAdminAsRead();

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

  // ======================= ATTACHMENT WIDGET =======================
  Widget _buildAttachmentWidget(AttachmentEntity att, bool isCurrentUser) {
    final lower = (att.url ?? att.name ?? '').toLowerCase();

    final isImage =
        lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.gif');

    final isPDF = lower.endsWith('.pdf');

    final isAudio =
        lower.endsWith('.mp3') ||
        lower.endsWith('.m4a') ||
        lower.endsWith('.wav') ||
        lower.endsWith('.aac');

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
          // ================= ICON =================
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
                  : isAudio
                  ? Icons.audiotrack
                  : Icons.insert_drive_file,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // ================= CONTENT =================
          Expanded(
            child: GestureDetector(
              onTap: () async {
                // 🖼 Image Preview
                if (isImage) {
                  showDialog(
                    context: context,
                    builder: (_) => Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: const EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          InteractiveViewer(
                            child: Image.network(att.url, fit: BoxFit.contain),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  return;
                }

                // 🎵 Audio handled by play button
                if (isAudio) return;

                // 📄 Any File (PDF / Word / Excel / ZIP)
                await launchUrl(
                  Uri.parse(att.url),
                  mode: LaunchMode.externalApplication,
                );
              },
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
                        : isAudio
                        ? "Audio File"
                        : "File",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),

                  // ================= AUDIO CONTROLS =================
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

    if (msg.messageType == "text" && (msg.content?.isNotEmpty ?? false)) {
      final hour = msg.createdAt.hour % 12 == 0 ? 12 : msg.createdAt.hour % 12;
      final period = msg.createdAt.hour >= 12 ? "PM" : "AM";

      widgets.add(
        _alignMessage(
          isCurrentUser: isCurrentUser,
          child: MessageBubble(
            isSent: msg.seenAt != null,
            userName: isCurrentUser
                ? SharedPrefHelper.getString("full_name") ?? ""
                : "Admin",
            sender: isCurrentUser ? SenderType.client : SenderType.admin,
            message: msg.content ?? "",
            time:
                "$hour:${msg.createdAt.minute.toString().padLeft(2, '0')} $period",
            chatWithUsers: true,
            avatarUrl: "",
          ),
        ),
      );
    }

    if (msg.attachment != null && msg.attachment!.isNotEmpty) {
      for (final att in msg.attachment!) {
        widgets.add(
          _alignMessage(
            isCurrentUser: isCurrentUser,
            child: _buildAttachmentWidget(att, isCurrentUser),
          ),
        );
      }
    }

    return widgets;
  }

  // ======================= BUILD =======================
  @override
  Widget build(BuildContext context) {
    final vm = context.read<ChatWithAdminViewModel>();

    return Column(
      children: [
        Expanded(
          child: BlocConsumer<ChatWithAdminViewModel, ChatWithAdminStates>(
            listener: (context, state) {
              if (vm.messages.length != _lastMessageCount) {
                _lastMessageCount = vm.messages.length;
                _scrollToBottom();
              }
            },
            builder: (context, state) {
              if (state is ChatWithAdminLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ChatWithAdminError) {
                return Center(
                  child: Lottie.asset(
                    'assets/lotties/no_internet.json',
                    width: 200,
                  ),
                );
              }

              final messages = vm.messages;

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  final isCurrentUser = msg.senderId == widget.currentUserId;

                  return Column(
                    crossAxisAlignment: isCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: _buildMessageContent(msg, isCurrentUser),
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

Widget _alignMessage({required bool isCurrentUser, required Widget child}) {
  return Align(
    alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
    child: child,
  );
}
