
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/message_entity.dart';
import '../../repositories/messages_repos/get_admin_messages_repo/get_admin_messages_repo.dart';
@injectable
  class GetAdminMessagesUseCase {
    GetAdminMessagesUseCase(this.repository);
    final GetAdminMessagesRepo repository;
  Future<Either<Failures,List<MessageEntity>>> getAdminMessages(String currentUserId){
    return repository.getAdminMessages(currentUserId);
  }
}