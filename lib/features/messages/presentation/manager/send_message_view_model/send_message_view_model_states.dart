import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/message_entity.dart';

class SendMessageViewModelStates {}
class SendMessageViewModelStatesInitial extends SendMessageViewModelStates {}
class SendMessageViewModelStatesLoading extends SendMessageViewModelStates {}
class SendMessageViewModelStatesSuccess extends SendMessageViewModelStates {
  final MessageEntity message;
  SendMessageViewModelStatesSuccess({required this.message});
}
class SendMessageViewModelStatesError extends SendMessageViewModelStates {
  final String failure;
  SendMessageViewModelStatesError({required this.failure});
}
class SendMessageViewModelStatesTemporary extends SendMessageViewModelStates {
  final List<MessageEntity> messages;
  SendMessageViewModelStatesTemporary({required this.messages});
}