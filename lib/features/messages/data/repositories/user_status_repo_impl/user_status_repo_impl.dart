import 'package:injectable/injectable.dart';

import '../../../domain/entities/user_status_entity/user_status_entity.dart';
import '../../../domain/repositories/messages_repos/user_status_repo/user_status_repo.dart';
import '../../data_sources/remote/user_status_remote_data_source/user_status_remote_data_source.dart';

@Injectable(as: UserStatusRepo )
class UserStatusRepoImpl implements UserStatusRepo{
  final UserStatusRemoteDataSource userStatusRemoteDataSource;
  UserStatusRepoImpl(this.userStatusRemoteDataSource);
  @override
  Stream<UserStatusEntity> streamUserStatus(String userId) {
   return userStatusRemoteDataSource.streamUserStatus(userId);
  }

}