import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/data/data_sources/remote/delete_message_remote_data_source/delete_message_remote_data_source.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/delete_message_repo/delete_message_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:  DeleteMessageRepo)
  class DeleteMessageRepoImpl  implements DeleteMessageRepo{
 DeleteMessageRemoteDataSource deleteMessageRemoteDataSource;

  DeleteMessageRepoImpl(this.deleteMessageRemoteDataSource);
  
  @override
  Future<Either<Failures, void>> deleteMessage(String messageId) {
     return deleteMessageRemoteDataSource.deleteMessage(messageId);
  } 
  
}