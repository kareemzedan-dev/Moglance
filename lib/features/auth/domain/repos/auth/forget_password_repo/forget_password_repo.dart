import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';

abstract class ForgetPasswordRepo {
  Future<Either<Failures,void>> forgetPassword(String email);
}