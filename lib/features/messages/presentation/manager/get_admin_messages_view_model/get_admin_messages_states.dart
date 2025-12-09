import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/message_entity.dart';

class GetAdminMessagesStates {}

class GetAdminMessagesInitial extends GetAdminMessagesStates {}

class GetAdminMessagesLoadingState extends GetAdminMessagesStates {}

class GetAdminMessagesSuccessState extends GetAdminMessagesStates {
  final List<MessageEntity> messages;
  GetAdminMessagesSuccessState(this.messages);
}

class GetAdminMessagesErrorState extends GetAdminMessagesStates {
  final Failures failure;
  GetAdminMessagesErrorState(this.failure);
}