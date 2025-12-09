
import 'package:injectable/injectable.dart';

import '../../entities/message_entity.dart';
import '../../repositories/messages_repos/subscribe_to_unread_messages_repo/subscribe_to_unread_messages_repo.dart';
@injectable
  class SubscribeToUnreadMessagesUseCase {
    final SubscribeToUnreadMessagesRepo repos;
    SubscribeToUnreadMessagesUseCase(this.repos);
  Stream<List<MessageEntity>> call ( String currentUserId )  {
    return repos.getUnreadMessagesStream(currentUserId);
  }
}