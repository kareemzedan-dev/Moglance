import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/messages/domain/repositories/messages_repos/mark_messages_as_read_repo/mark_messages_as_read_repo.dart';
import '../../../../../core/errors/failures.dart';

@lazySingleton
class MarkMessagesAsReadUseCase {
  final MarkMessagesAsReadRepo repository;

  MarkMessagesAsReadUseCase(this.repository);

  Future<Either<Failures, void>> call(String orderId,String currentId) {
    return repository.markMessagesAsRead(orderId,currentId);
  }
}
