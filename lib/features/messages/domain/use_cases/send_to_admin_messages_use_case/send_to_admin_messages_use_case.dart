import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/message_entity.dart';
import '../../repositories/messages_repos/send_to_admin_messages_repo/send_to_admin_messages_repo.dart';

@injectable
class SendToAdminMessagesUseCase {
  final SendToAdminMessagesRepo repo;

  SendToAdminMessagesUseCase(this.repo);

  Future<Either<Failures, void>> SendToAdminMessage({required MessageEntity message}) {
    return repo.SendToAdminMessage(message: message);
  }
}
