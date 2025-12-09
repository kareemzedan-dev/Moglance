import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../repositories/update_user_profile_repo/update_user_profile_repo.dart';
@injectable
class UpdateUserProfileUseCase {
  final UpdateUserProfileRepo updateUserProfileRepo;

  UpdateUserProfileUseCase(this.updateUserProfileRepo);

  Future<Either<Failures, void>> callUpdateUserInfo(
          String userId,

          String fullName,
          String email,
          String phoneNumber,
          String profileImage) =>
      updateUserProfileRepo.updateUserInfo(
        userId,

        fullName,
        email,
        phoneNumber,
        profileImage,
      );
}
