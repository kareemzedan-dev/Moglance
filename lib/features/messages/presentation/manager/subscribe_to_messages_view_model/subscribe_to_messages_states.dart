import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/messages/domain/entities/message_entity.dart';

class SubscribeToMessagesStates {}

class SubscribeToMessagesStatesSuccess extends SubscribeToMessagesStates {
    final List<MessageEntity> messages;
  SubscribeToMessagesStatesSuccess({required this.messages});
}

class SubscribeToMessagesStatesError extends SubscribeToMessagesStates {
  final Failures failure;
  SubscribeToMessagesStatesError({required this.failure});
}

class SubscribeToMessagesStatesLoading extends SubscribeToMessagesStates {}

class SubscribeToMessagesStatesInitial extends SubscribeToMessagesStates {}