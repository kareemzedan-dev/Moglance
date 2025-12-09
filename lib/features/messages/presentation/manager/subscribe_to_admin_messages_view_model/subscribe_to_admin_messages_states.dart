import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/message_entity.dart';

class SubscribeToAdminMessagesStates {}
class SubscribeToAdminMessagesInitial extends SubscribeToAdminMessagesStates {}
class SubscribeToAdminMessagesLoadingState extends SubscribeToAdminMessagesStates {}
class SubscribeToAdminMessagesSuccessState extends SubscribeToAdminMessagesStates {
  final List<MessageEntity> messages;

  SubscribeToAdminMessagesSuccessState(this.messages);
}

class SubscribeToAdminMessagesErrorState extends SubscribeToAdminMessagesStates {
  final Failures failure;
  SubscribeToAdminMessagesErrorState(this.failure);

}