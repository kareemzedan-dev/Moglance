

import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import '../../../domain/repositories/update_user_profile_repo/update_user_profile_repo.dart';
import '../../data_sources/update_user_profile_remote_data_source/update_user_profile_remote_data_source.dart';
@Injectable(as:  UpdateUserProfileRepo)
class UpdateUserProfileRepoImpl implements UpdateUserProfileRepo {
  final UpdateUserProfileRemoteDataSource updateUserProfileRemoteDataSource;
  UpdateUserProfileRepoImpl(this.updateUserProfileRemoteDataSource);

  @override
  Future<Either<Failures, void>> updateUserInfo(String userId,   String fullName, String email, String phoneNumber, String profileImage) {
  return updateUserProfileRemoteDataSource.updateUserInfo(userId, fullName, email, phoneNumber, profileImage);
  }

}