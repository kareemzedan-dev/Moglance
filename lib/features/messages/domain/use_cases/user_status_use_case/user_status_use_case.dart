import 'package:injectable/injectable.dart';

import '../../entities/user_status_entity/user_status_entity.dart';
import '../../repositories/messages_repos/user_status_repo/user_status_repo.dart';
@injectable
class UserStatusUseCase {
  final UserStatusRepo userStatusRepo;
  UserStatusUseCase({required this.userStatusRepo});
  Stream<UserStatusEntity> streamUserStatus(String userId) {
    return userStatusRepo.streamUserStatus(userId);
  }
}