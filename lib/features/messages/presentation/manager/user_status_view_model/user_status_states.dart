
import '../../../domain/entities/user_status_entity/user_status_entity.dart';

class UserStatusStates {}
class UserStatusInitialStates extends UserStatusStates {}
class UserStatusLoadingStates extends UserStatusStates {}
class UserStatusSuccessStates extends UserStatusStates {
  final UserStatusEntity userStatus;
  UserStatusSuccessStates({required this.userStatus});
}
class UserStatusErrorStates extends UserStatusStates {
  final String message;
  UserStatusErrorStates({required this.message});
}