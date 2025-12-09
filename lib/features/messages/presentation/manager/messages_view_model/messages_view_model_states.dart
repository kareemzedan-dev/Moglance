import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';

  class MessagesStates {}

class MessagesInitial extends MessagesStates {}

class MessagesLoading extends MessagesStates {}

class MessagesSuccess extends MessagesStates {
  final List<MessageEntity> messages;
  MessagesSuccess({required this.messages});
}

class MessagesError extends MessagesStates {
  final Failures failure;
  MessagesError({required this.failure});
}
