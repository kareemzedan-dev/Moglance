import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/message_entity.dart';

class GetMessagesViewModelStates {}
class GetMessagesViewModelStatesInitial extends GetMessagesViewModelStates {}

class GetMessagesViewModelStatesLoading extends GetMessagesViewModelStates {}

class GetMessagesViewModelStatesError extends GetMessagesViewModelStates {
  final Failures failure;
  GetMessagesViewModelStatesError({required this.failure});
}

class GetMessagesViewModelStatesSuccess extends GetMessagesViewModelStates {
  final List<MessageEntity> messages;
  GetMessagesViewModelStatesSuccess({required this.messages});
}