import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/send_messages_repo/send_messages_repo.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../features/messages/domain/entities/message_entity.dart';

@lazySingleton
class SendMessageUseCase {
  final SendMessagesRepo repository;

  SendMessageUseCase(this.repository);

  Future<Either<Failures, MessageEntity>> call(String orderId, MessageEntity message) {
    return repository.sendMessage(orderId, message);
  }

}
