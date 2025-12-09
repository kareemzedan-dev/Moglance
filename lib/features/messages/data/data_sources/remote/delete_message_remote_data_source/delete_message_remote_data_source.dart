import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';

abstract class DeleteMessageRemoteDataSource {
    Future<Either<Failures, void>> deleteMessage(String messageId);
}