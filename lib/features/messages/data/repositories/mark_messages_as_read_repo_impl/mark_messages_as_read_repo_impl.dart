import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/data/data_sources/remote/mark_messages_as_read_remote_data_source/mark_messages_as_read_remote_data_source.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/mark_messages_as_read_repo/mark_messages_as_read_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:  MarkMessagesAsReadRepo)
class MarkMessagesAsReadRepoImpl implements MarkMessagesAsReadRepo {
  MarkMessagesAsReadRemoteDataSource remoteDataSource;

  MarkMessagesAsReadRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failures, void>> markMessagesAsRead(String orderId,String currentUserId) {
    return remoteDataSource.markMessagesAsRead(orderId, currentUserId);
  }
  @override
  Future<Either<Failures, void>> markAdminMessagesAsRead(String currentUserId) {
    return remoteDataSource.markAdminMessagesAsRead(currentUserId);
  }
}
