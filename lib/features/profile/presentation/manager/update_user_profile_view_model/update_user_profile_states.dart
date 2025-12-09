class UpdateUserProfileStates {}
class UpdateUserProfileStatesInitial extends UpdateUserProfileStates {}

class UpdateUserProfileStatesLoading extends UpdateUserProfileStates {}

class UpdateUserProfileStatesSuccess extends UpdateUserProfileStates {
  String message;
  UpdateUserProfileStatesSuccess(this.message);
}

class UpdateUserProfileStatesError extends UpdateUserProfileStates {
  String message;
  UpdateUserProfileStatesError(this.message);
}