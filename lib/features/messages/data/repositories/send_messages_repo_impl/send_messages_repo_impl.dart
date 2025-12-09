import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/data/data_sources/remote/send_messages_remote_data_source/send_messages_remote_data_source.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/send_messages_repo/send_messages_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:  SendMessagesRepo)
class SendMessagesRepoImpl implements SendMessagesRepo {
  SendMessagesRemoteDataSource remoteDataSource;
  SendMessagesRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failures, MessageEntity>> sendMessage(
      String orderId, MessageEntity message) {
    return remoteDataSource.sendMessage(orderId, message);
  }
}
