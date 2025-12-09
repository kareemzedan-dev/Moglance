import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/conversation_entity.dart';
import '../../repositories/messages_repos/get_conversation_repo/get_conversation_repo.dart';

@injectable
  class GetConversationsUseCase {
  GetConversationRepo repos;
  GetConversationsUseCase(this.repos);

  Future<Either<Failures, List<ConversationEntity>>> call(String userId) {
    return repos.getConversations(userId);
  }

  Stream<List<ConversationEntity>> subscribeToConversations(String userId) {
    return repos.subscribeToConversations(userId);
  }

}