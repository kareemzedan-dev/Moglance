import '../../../entities/message_entity.dart';

abstract class SubscribeToUnreadMessagesRepo {
  Stream<List<MessageEntity>> getUnreadMessagesStream ( String currentUserId );
}