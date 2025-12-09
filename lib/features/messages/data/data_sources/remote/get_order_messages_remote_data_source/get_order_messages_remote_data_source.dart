import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';

abstract class GetOrderMessagesRemoteDataSource {
    Future<Either<Failures, List<MessageEntity>>> getOrderMessages(String orderId, String currentUserId, String otherUserId);


}