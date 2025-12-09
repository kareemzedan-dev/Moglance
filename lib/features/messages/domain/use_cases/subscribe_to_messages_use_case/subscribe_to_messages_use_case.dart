import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/subscribe_to_messages_repo/subscribe_to_messages_repo.dart';

@injectable
class SubscribeToMessagesUseCase {
  final SubscribeToMessagesRepo repos;

  SubscribeToMessagesUseCase(this.repos);

  Stream<(MessageEntity, String)> call(String orderId, String currentUserId, String otherUserId) {
    return repos.subscribeToMessages(orderId, currentUserId, otherUserId);
  }
}
