import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/data/data_sources/remote/get_order_messages_remote_data_source/get_order_messages_remote_data_source.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/get_order_messages_repo/get_order_messages_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:  GetOrderMessagesRepo)
  class GetOrderMessagesRepoImpl implements GetOrderMessagesRepo{
   GetOrderMessagesRemoteDataSource remoteDataSource;

   GetOrderMessagesRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failures, List<MessageEntity>>> getOrderMessages(String orderId, String currentUserId, String otherUserId) {
    return remoteDataSource.getOrderMessages(orderId, currentUserId, otherUserId);
  }
}