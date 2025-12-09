import '../../../entities/user_status_entity/user_status_entity.dart';

abstract class UserStatusRepo {
  Stream<UserStatusEntity> streamUserStatus(String userId);

}