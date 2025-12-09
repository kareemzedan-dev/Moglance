
import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/conversation_entity.dart';

abstract class GetConversationRepo {
  Future<Either<Failures ,List<ConversationEntity >>> getConversations(String userId);

  Stream<List<ConversationEntity>> subscribeToConversations(String userId);
}