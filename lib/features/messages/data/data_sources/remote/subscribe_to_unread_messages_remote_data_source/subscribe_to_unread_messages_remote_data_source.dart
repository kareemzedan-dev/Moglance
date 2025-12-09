import '../../../../domain/entities/message_entity.dart';

abstract class SubscribeToUnreadMessagesRemoteDataSource {
  Stream<List<MessageEntity>> getUnreadMessagesStream(String currentUserId);
}
