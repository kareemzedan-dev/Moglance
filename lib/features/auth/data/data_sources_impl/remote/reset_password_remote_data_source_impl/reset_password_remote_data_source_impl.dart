import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import '../../../data_sources/remote/reset_password_remote_data_source/reset_password_remote_data_source.dart';
@Injectable(as: ResetPasswordRemoteDataSource)
class ResetPasswordRemoteDataSourceImpl implements ResetPasswordRemoteDataSource{
  @override
  Future<Either<Failures, void>> resetPassword({required String accessToken, required String newPassword}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

}