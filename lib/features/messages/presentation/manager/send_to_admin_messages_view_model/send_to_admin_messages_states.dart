class SendToAdminMessagesStates {}
class SendToAdminMessagesInitial extends SendToAdminMessagesStates {}
class SendToAdminMessagesLoadingState extends SendToAdminMessagesStates {}
class SendToAdminMessagesSuccessState extends SendToAdminMessagesStates {
  String message;
  SendToAdminMessagesSuccessState(this.message);
}
class SendToAdminMessagesErrorState extends SendToAdminMessagesStates {
  String message;
  SendToAdminMessagesErrorState(this.message);
}