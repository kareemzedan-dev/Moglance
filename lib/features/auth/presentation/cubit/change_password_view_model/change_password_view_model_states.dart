class ChangePasswordViewModelStates {}
class ChangePasswordViewModelInitial extends ChangePasswordViewModelStates {}
class ChangePasswordViewModelLoadingState extends ChangePasswordViewModelStates {}
class ChangePasswordViewModelSuccessState extends ChangePasswordViewModelStates {
  final String message;
  ChangePasswordViewModelSuccessState(this.message);
}
class ChangePasswordViewModelErrorState extends ChangePasswordViewModelStates {
  String message;
  ChangePasswordViewModelErrorState(this.message);
}