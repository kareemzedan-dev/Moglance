import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/get_order_messages_repo/get_order_messages_repo.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../features/messages/domain/entities/message_entity.dart';

@lazySingleton
class GetOrderMessagesUseCase {
  final GetOrderMessagesRepo repository;

  GetOrderMessagesUseCase(this.repository);

  Future<Either<Failures, List<MessageEntity>>> call(String orderId, String currentUserId, String otherUserId) {
    return repository.getOrderMessages(orderId, currentUserId, otherUserId);
  }
 
}
