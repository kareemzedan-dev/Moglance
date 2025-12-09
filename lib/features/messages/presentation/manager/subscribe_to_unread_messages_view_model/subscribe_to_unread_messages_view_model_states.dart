import '../../../domain/entities/message_entity.dart';

class SubscribeToUnreadMessagesViewModelStates {}
class SubscribeToUnreadMessagesViewModelStatesInitial extends SubscribeToUnreadMessagesViewModelStates {}

class SubscribeToUnreadMessagesViewModelStatesLoading extends SubscribeToUnreadMessagesViewModelStates {}

class SubscribeToUnreadMessagesViewModelStatesSuccess extends SubscribeToUnreadMessagesViewModelStates {
  final List<MessageEntity> messages;
  SubscribeToUnreadMessagesViewModelStatesSuccess(this.messages);
}

class SubscribeToUnreadMessagesViewModelStatesError extends SubscribeToUnreadMessagesViewModelStates {
  final String error;
  SubscribeToUnreadMessagesViewModelStatesError(this.error);
}

