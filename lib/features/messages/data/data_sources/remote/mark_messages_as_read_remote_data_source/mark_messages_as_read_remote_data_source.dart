import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';

abstract class MarkMessagesAsReadRemoteDataSource {
    Future<Either<Failures, void>> markMessagesAsRead(String orderId,String currentUserId);
    Future<Either<Failures, void>> markAdminMessagesAsRead(String currentUserId);
}