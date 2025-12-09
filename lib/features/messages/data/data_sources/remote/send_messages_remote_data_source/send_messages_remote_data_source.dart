import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';

abstract class SendMessagesRemoteDataSource {
    Future<Either<Failures, MessageEntity>> sendMessage(String orderId, MessageEntity message);
}