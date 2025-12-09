import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class ResetPasswordRepo {
  Future<Either<Failures, void>> resetPassword({
    required String accessToken,
    required String newPassword,
  });
}
