
import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/conversation_entity.dart';

abstract class GetConversationsRemoteDataSource {

  Future<Either<Failures, List<ConversationEntity>>> getConversations(String userId);


  Stream<List<ConversationEntity>> subscribeToConversations(String userId);
}