class ForgetPasswordViewModelStates {}
class ForgetPasswordViewModelStatesInitial extends ForgetPasswordViewModelStates {}
class ForgetPasswordViewModelStatesLoading extends ForgetPasswordViewModelStates {}

class ForgetPasswordViewModelStatesSuccess extends ForgetPasswordViewModelStates {
  final String message;
  ForgetPasswordViewModelStatesSuccess(this.message);
}

class ForgetPasswordViewModelStatesError extends ForgetPasswordViewModelStates {
  final String message;
  ForgetPasswordViewModelStatesError(this.message);
}