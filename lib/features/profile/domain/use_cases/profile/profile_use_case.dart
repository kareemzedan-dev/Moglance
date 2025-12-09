import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';

import '../../entities/user_info_entity/user_info_entity.dart';
import '../../repositories/profile/profile_repo.dart';
@injectable
class ProfileUseCase {
  ProfileRepo profileRepo;

  ProfileUseCase(this.profileRepo);
 Future<Either<Failures,UserInfoEntity>> callUserInfo(
     String userId,
     String role,

     ) => profileRepo.getUserInfo(
   userId,
   role,
 );
}