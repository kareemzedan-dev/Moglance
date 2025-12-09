 
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/features/messages/data/data_sources/remote/subscribe_to_messages_remote_data_source/subscribe_to_messages_remote_data_source.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/subscribe_to_messages_repo/subscribe_to_messages_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:  SubscribeToMessagesRepo)
class SubscribeToMessagesRepoImpl implements SubscribeToMessagesRepo {
  SubscribeToMessagesRemoteDataSource remoteDataSource;
  SubscribeToMessagesRepoImpl({required this.remoteDataSource});
  @override
  Stream<(MessageEntity, String)> subscribeToMessages(String orderId,
      String currentUserId, String otherUserId,
      ) {
    return remoteDataSource.subscribeToMessages(orderId, currentUserId, otherUserId);
  }
}
