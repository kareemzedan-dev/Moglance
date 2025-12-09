
  import '../../../domain/entities/message_entity.dart';

class ChatWithAdminStates {}

class ChatWithAdminInitial extends ChatWithAdminStates {}
class ChatWithAdminLoading extends ChatWithAdminStates {}
class ChatWithAdminLoaded extends ChatWithAdminStates {
  final List<MessageEntity> messages;
  ChatWithAdminLoaded(this.messages);
}
class ChatWithAdminError extends ChatWithAdminStates {
  final String message;
  ChatWithAdminError(this.message);
}
