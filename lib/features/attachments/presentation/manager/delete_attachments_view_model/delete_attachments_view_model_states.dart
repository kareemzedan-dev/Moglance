class DeleteAttachmentsViewModelStates {}
class DeleteAttachmentsViewModelStatesInitial extends DeleteAttachmentsViewModelStates {}

class DeleteAttachmentsViewModelStatesLoading extends DeleteAttachmentsViewModelStates {}
class DeleteAttachmentsViewModelStatesSuccess extends DeleteAttachmentsViewModelStates {
  String message;
  DeleteAttachmentsViewModelStatesSuccess(this.message);
}
class DeleteAttachmentsViewModelStatesError extends DeleteAttachmentsViewModelStates {
  String message;
  DeleteAttachmentsViewModelStatesError(this.message);
}