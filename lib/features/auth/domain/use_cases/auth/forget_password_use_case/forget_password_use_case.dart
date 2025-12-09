import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../repos/auth/forget_password_repo/forget_password_repo.dart';
@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepo forgetPasswordRepo;
  ForgetPasswordUseCase(this.forgetPasswordRepo);
  Future<Either<Failures, void>> call(String email) => forgetPasswordRepo.forgetPassword(email);

}