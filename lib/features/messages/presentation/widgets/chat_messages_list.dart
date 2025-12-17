// chat/presentation/widgets/chat_messages_list.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:taskly/features/messages/presentation/widgets/message_shimmer.dart';
import 'package:taskly/features/messages/presentation/manager/get_messages_view_model/get_messages_view_model.dart';
import 'package:taskly/features/messages/presentation/manager/get_messages_view_model/get_messages_view_model_states.dart';
import 'package:taskly/features/messages/presentation/widgets/pending_message_widget.dart';
import '../../data/models/pending_message_model/pending_message_model.dart';
import '../manager/pending_messages_view_model/pending_messages_view_model.dart';
import '../manager/subscribe_to_messages_view_model/subscribe_to_messages_states.dart';
import '../manager/subscribe_to_messages_view_model/subscribe_to_messages_view_model.dart';
import 'media_message_widget.dart';
import 'file_message_widget.dart';
import 'voice_message_widget.dart';
import 'text_message_bubble.dart';

class ChatMessagesList extends StatelessWidget {
  final String currentUserId;
  final ScrollController scrollController;
  final String? freelancerAvatar;
  final String? clientAvatar;
  final String userName;

  const ChatMessagesList({
    super.key,
    required this.currentUserId,
    required this.scrollController,
    required this.freelancerAvatar,
    required this.clientAvatar,
    required this.userName,
  });

  // في chat_messages_list.dart
  @override
  Widget build(BuildContext context) {
    return Consumer<PendingMessagesViewModel>(
      builder: (context, pendingMessagesVM, child) {
        print(
          '🔄 إعادة بناء ChatMessagesList - الرسائل المؤقتة: ${pendingMessagesVM.pendingMessages.length}',
        );

        return BlocBuilder<GetMessagesViewModel, GetMessagesViewModelStates>(
          builder: (context, oldState) {
            List<dynamic> allMessages = [];

            // إضافة الرسائل العادية
            if (oldState is GetMessagesViewModelStatesSuccess) {
              allMessages.addAll(oldState.messages);
              print('📨 الرسائل العادية: ${oldState.messages.length}');
            }

            // إضافة الرسائل الجديدة من الاشتراك
            return BlocBuilder<
              SubscribeToMessagesViewModel,
              SubscribeToMessagesStates
            >(
              builder: (context, newState) {
                if (newState is SubscribeToMessagesStatesSuccess) {
                  for (var msg in newState.messages) {
                    if (!allMessages.any((m) => m.id == msg.id)) {
                      allMessages.add(msg);
                    }
                  }
                  print('🆕 الرسائل الجديدة: ${newState.messages.length}');
                }

                // إضافة الرسائل أثناء الإرسال (المؤقتة)
                final pendingMessages = pendingMessagesVM.pendingMessages;
                allMessages.addAll(pendingMessages);
                print('⏳ الرسائل المؤقتة: ${pendingMessages.length}');

                // ترتيب الرسائل حسب الوقت
                allMessages.sort((a, b) {
                  final aTime = a is PendingMessage ? a.createdAt : a.createdAt;
                  final bTime = b is PendingMessage ? b.createdAt : b.createdAt;
                  return aTime.compareTo(bTime);
                });

                print('📋 إجمالي الرسائل المعروضة: ${allMessages.length}');

                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: allMessages.length,
                  itemBuilder: (context, index) {
                    final message = allMessages[index];

                    if (message is PendingMessage) {
                      print(
                        '👻 عرض رسالة مؤقتة: ${message.id} - ${message.type}',
                      );
                      return PendingMessageWidget(
                        userName: userName,
                        pendingMessage: message,
                        avatarUrl: message.isCurrentUser
                            ? freelancerAvatar ?? ""
                            : clientAvatar ?? "",
                      );
                    }
                    final msg = message;
                    final isCurrentUser = msg.senderId == currentUserId;

                    // ✅ فك الـ attachment
                    final attachments = parseAttachments(msg.attachment);

                    // ✅ هات الـ fileUrl الحقيقي
                    final String? fileUrl = attachments.isNotEmpty
                        ? attachments.first['url'] as String?
                        : null;

                    // ✅ حدّد النوع من الامتداد
                    final messageType = _getMessageType(
                      msg.messageType,
                      url: fileUrl,
                    );

                    return _buildMessageWidget(
                      context,
                      msg: msg,
                      isCurrentUser: isCurrentUser,
                      messageType: messageType,
                      fileUrl: fileUrl,
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  // ... باقي الدوال كما هي بدون تغيير
  Widget _buildMessageWidget(
    BuildContext context, {
    required dynamic msg,
    required bool isCurrentUser,
    required MessagesType messageType,
    required String? fileUrl,
  }) {
    final lower = fileUrl?.toLowerCase() ?? '';

    // 🔥 حارس أمان: الصوت فقط لو الامتداد صوت
    final isAudioFile =
        lower.endsWith('.mp3') ||
        lower.endsWith('.m4a') ||
        lower.endsWith('.wav') ||
        lower.endsWith('.aac');

    if (isAudioFile && fileUrl != null) {
      return VoiceMessageWidget(
        userName: userName,
        fileUrl: fileUrl,
        time: _formatTime(msg.createdAt),
        isCurrentUser: isCurrentUser,
        avatarUrl: isCurrentUser ? freelancerAvatar ?? "" : clientAvatar ?? "",
      );
    }

    // 🖼 صورة
    if (messageType == MessagesType.image && fileUrl != null) {
      return MediaMessageWidget(
        userName: userName,
        fileUrl: fileUrl,
        time: _formatTime(msg.createdAt),
        isCurrentUser: isCurrentUser,
        avatarUrl: isCurrentUser ? freelancerAvatar ?? "" : clientAvatar ?? "",
        caption: msg.content,
      );
    }

    // 📄 أي ملف تاني (PDF / Word / Excel)
    if (fileUrl != null) {
      return FileMessageWidget(
        userName: userName,
        fileUrl: fileUrl,
        time: _formatTime(msg.createdAt),
        isCurrentUser: isCurrentUser,
        avatarUrl: isCurrentUser ? freelancerAvatar ?? "" : clientAvatar ?? "",
      );
    }

    // 📝 نص
    return TextMessageBubble(
      userName: userName,
      message: msg.content ?? "",
      time: _formatTime(msg.createdAt),
      isCurrentUser: isCurrentUser,
      avatarUrl: isCurrentUser ? freelancerAvatar ?? "" : clientAvatar ?? "",
    );
  }

  String _formatTime(DateTime dateTime) {
    return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  bool _isImageMessage(dynamic msg) {
    if (msg.attachment == null || msg.attachment!.isEmpty) return false;
    final url = msg.attachment!.first.url.toLowerCase();
    return url.endsWith('.jpg') ||
        url.endsWith('.jpeg') ||
        url.endsWith('.png') ||
        url.endsWith('.gif');
  }

  MessagesType _getMessageType(String _, {String? url}) {
    if (url == null) return MessagesType.text;

    final lower = url.toLowerCase();

    // 🖼 Images
    if (lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.gif')) {
      return MessagesType.image;
    }

    // 🎵 Audio
    if (lower.endsWith('.mp3') ||
        lower.endsWith('.m4a') ||
        lower.endsWith('.wav') ||
        lower.endsWith('.aac')) {
      return MessagesType.audio;
    }

    // 📄 أي ملف تاني (PDF / Word / Excel / PPT)
    return MessagesType.file;
  }
}

enum MessagesType {
  text, // رسالة نصية
  audio, // رسالة صوتية
  file, // ملف (PDF، Word، إلخ)
  image, // صورة (ممكن تستخدمه مع MediaMessageWidget)
}

List<dynamic> parseAttachments(dynamic raw) {
  if (raw == null) return [];

  if (raw is String) {
    try {
      return jsonDecode(raw);
    } catch (_) {
      return [];
    }
  }

  if (raw is List) {
    return raw;
  }

  return [];
}
