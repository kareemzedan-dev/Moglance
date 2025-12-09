import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/auth/data/data_sources/remote/change_password_remote_data_source/change_password_remote_data_source.dart';

import '../../../../domain/repos/auth/change_password_repo/change_password_repo.dart';
@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo{
  ChangePasswordRemoteDataSource  changePasswordRemoteDataSource ;
  ChangePasswordRepoImpl(this.changePasswordRemoteDataSource);
  @override
  Future<Either<Failures, void>> changePassword(String currentPassword, String newPassword) {
    return changePasswordRemoteDataSource.changePassword(currentPassword, newPassword);
  }

}