import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/auth/domain/repos/auth/reset_password_repo/reset_password_repo.dart';

import '../../../../../../core/errors/failures.dart';
@injectable
class ResetPasswordUseCase {
  final ResetPasswordRepo resetPasswordRepo ;
  ResetPasswordUseCase(this.resetPasswordRepo) ;

  Future<Either<Failures, void>> call({required String accessToken, required String newPassword}) async {
    return await resetPasswordRepo.resetPassword(accessToken: accessToken, newPassword: newPassword);
  }
}