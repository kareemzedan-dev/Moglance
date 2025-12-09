import '../../../../domain/entities/user_status_entity/user_status_entity.dart';

abstract class UserStatusRemoteDataSource {
  Stream<UserStatusEntity> streamUserStatus(String userId);
}