
import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class ForgetPasswordRemoteDataSource {
  Future<Either<Failures, void>> forgetPassword(String email) ;
}