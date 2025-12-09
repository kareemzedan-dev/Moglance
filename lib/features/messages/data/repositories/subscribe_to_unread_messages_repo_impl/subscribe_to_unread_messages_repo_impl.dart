import 'package:injectable/injectable.dart';

import '../../../domain/entities/message_entity.dart';
import '../../../domain/repositories/messages_repos/subscribe_to_unread_messages_repo/subscribe_to_unread_messages_repo.dart';
import '../../data_sources/remote/subscribe_to_unread_messages_remote_data_source/subscribe_to_unread_messages_remote_data_source.dart';
@Injectable(as:  SubscribeToUnreadMessagesRepo)
class SubscribeToUnreadMessagesRepoImpl implements SubscribeToUnreadMessagesRepo {
  final SubscribeToUnreadMessagesRemoteDataSource remoteDataSource;
  SubscribeToUnreadMessagesRepoImpl(this.remoteDataSource);
  @override
  Stream<List<MessageEntity>> getUnreadMessagesStream(String currentUserId) {
    return  remoteDataSource.getUnreadMessagesStream(currentUserId);
  }
}