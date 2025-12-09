// models/pending_message_model.dart

import '../../../presentation/widgets/chat_messages_list.dart';

class PendingMessage {
  final String id;
  final String content;
  final String? filePath;
  final String? fileUrl;
  final MessagesType type;
  final DateTime createdAt;
  final bool isCurrentUser;
  final String? caption;
  final double uploadProgress;

  PendingMessage({
    required this.id,
    required this.content,
    this.filePath,
    this.fileUrl,
    required this.type,
    required this.createdAt,
    required this.isCurrentUser,
    this.caption,
    this.uploadProgress = 0.0,
  });

  PendingMessage copyWith({
    double? uploadProgress,
    String? fileUrl,
  }) {
    return PendingMessage(
      id: id,
      content: content,
      filePath: filePath,
      fileUrl: fileUrl ?? this.fileUrl,
      type: type,
      createdAt: createdAt,
      isCurrentUser: isCurrentUser,
      caption: caption,
      uploadProgress: uploadProgress ?? this.uploadProgress,
    );
  }
}