

import '../../../domain/entities/conversation_entity.dart';

class GetConversationsStates {}

class GetConversationsInitialStates extends GetConversationsStates {}

class GetConversationsLoadingStates extends GetConversationsStates {}

class GetConversationsSuccessStates extends GetConversationsStates {
  List<ConversationEntity> conversationsList;
  GetConversationsSuccessStates({required this.conversationsList});
}

class GetConversationsErrorStates extends GetConversationsStates {
  String errorMessage;
  GetConversationsErrorStates({required this.errorMessage});
}