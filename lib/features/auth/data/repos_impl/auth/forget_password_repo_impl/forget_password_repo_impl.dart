
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import '../../../../domain/repos/auth/forget_password_repo/forget_password_repo.dart';
import '../../../data_sources/remote/forget_password_remote_data_source/forget_password_remote_data_source.dart';
@Injectable(as:  ForgetPasswordRepo)
class ForgetPasswordRepoImpl implements ForgetPasswordRepo{
  final ForgetPasswordRemoteDataSource remoteDataSource;
  ForgetPasswordRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, void>> forgetPassword(String email) {
 return remoteDataSource.forgetPassword(email);
  }

}