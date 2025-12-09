import 'package:taskly/features/profile/domain/entities/user_info_entity/user_info_entity.dart';

class ProfileViewModelStates {}

class ProfileViewModelStatesInitial extends ProfileViewModelStates {}

class ProfileViewModelStatesError extends ProfileViewModelStates {
  final String message;
  ProfileViewModelStatesError(this.message);
}

class ProfileViewModelStatesSuccess extends ProfileViewModelStates {
  final UserInfoEntity userInfoEntity;

  ProfileViewModelStatesSuccess(this.userInfoEntity);
}

class ProfileViewModelStatesLoading extends ProfileViewModelStates {}

class ProfileViewModelStatesCacheUpdated extends ProfileViewModelStates {}
