import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/delete_message_repo/delete_message_repo.dart';
import '../../../../../core/errors/failures.dart';

@lazySingleton
class DeleteMessageUseCase {
  final DeleteMessageRepo repository;

  DeleteMessageUseCase(this.repository);

  Future<Either<Failures, void>> call(String messageId) {
    return repository.deleteMessage(messageId);
  }
}
