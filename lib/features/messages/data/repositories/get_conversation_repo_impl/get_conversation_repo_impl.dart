

import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';


import '../../../domain/entities/conversation_entity.dart';
import '../../../domain/repositories/messages_repos/get_conversation_repo/get_conversation_repo.dart';
import '../../data_sources/remote/get_conversations_remote_data_source/get_conversations_remote_data_source.dart';
@Injectable(as:  GetConversationRepo)
class GetConversationRepoImpl extends GetConversationRepo {
  GetConversationsRemoteDataSource remoteDataSource;
  GetConversationRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, List<ConversationEntity>>> getConversations(String userId) {
 return remoteDataSource.getConversations(userId);
  }

  @override
  Stream<List<ConversationEntity>> subscribeToConversations(String userId) {
    return remoteDataSource.subscribeToConversations(userId);
  }
}