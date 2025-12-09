import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';

import '../../../repos/auth/change_password_repo/change_password_repo.dart';
@injectable
class ChangePasswordUseCase {
  final ChangePasswordRepo changePasswordRepo;
  ChangePasswordUseCase(this.changePasswordRepo);

  Future<Either<Failures,void>> call(String currentPassword, String newPassword   ) {
    return changePasswordRepo.changePassword(currentPassword, newPassword);
  }
}