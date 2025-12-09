// manager/pending_messages_view_model/pending_messages_view_model.dart
import 'package:flutter/foundation.dart';

import '../../../data/models/pending_message_model/pending_message_model.dart';
// في pending_messages_view_model.dart
class PendingMessagesViewModel extends ChangeNotifier {
  final List<PendingMessage> _pendingMessages = [];

  List<PendingMessage> get pendingMessages => _pendingMessages;

  void addPendingMessage(PendingMessage message) {
    print('➕ إضافة رسالة مؤقتة: ${message.id}');
    _pendingMessages.add(message);
    notifyListeners();
  }

  void removePendingMessage(String messageId) {
    print('➖ إزالة رسالة مؤقتة: $messageId');
    _pendingMessages.removeWhere((msg) => msg.id == messageId);
    notifyListeners();
  }

  void updateUploadProgress(String messageId, double progress) {
    final index = _pendingMessages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      final updatedMessage = PendingMessage(
        id: _pendingMessages[index].id,
        content: _pendingMessages[index].content,
        filePath: _pendingMessages[index].filePath,
        type: _pendingMessages[index].type,
        createdAt: _pendingMessages[index].createdAt,
        isCurrentUser: _pendingMessages[index].isCurrentUser,
        caption: _pendingMessages[index].caption,
        uploadProgress: progress,
      );

      _pendingMessages[index] = updatedMessage;
      notifyListeners();
      print('📊 تحديث تقدم الرسالة: $messageId - $progress');
    }
  }

  void updateMessageWithFileUrl(String messageId, String fileUrl) {
    final index = _pendingMessages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      final updatedMessage = PendingMessage(
        id: _pendingMessages[index].id,
        content: _pendingMessages[index].content,
        filePath: _pendingMessages[index].filePath,
        type: _pendingMessages[index].type,
        createdAt: _pendingMessages[index].createdAt,
        isCurrentUser: _pendingMessages[index].isCurrentUser,
        caption: _pendingMessages[index].caption,
        uploadProgress: 1.0,
      );

      _pendingMessages[index] = updatedMessage;
      notifyListeners();
      print('🔗 تحديث رابط الملف للرسالة: $messageId');
    }
  }
}