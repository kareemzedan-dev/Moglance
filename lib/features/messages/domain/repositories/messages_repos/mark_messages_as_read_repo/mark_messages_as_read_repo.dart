import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';

abstract class MarkMessagesAsReadRepo {
    Future<Either<Failures, void>> markMessagesAsRead(String orderId,String currentUserId);
}