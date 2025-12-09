import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/profile/data/data_sources/profile_remote_data_source.dart';

import '../../../domain/entities/user_info_entity/user_info_entity.dart';
import '../../../domain/repositories/profile/profile_repo.dart';
@Injectable(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo{
  ProfileRemoteDataSource profileRemoteDataSource;

  ProfileRepoImpl(this.profileRemoteDataSource);
  @override
  Future<Either<Failures, UserInfoEntity>> getUserInfo(
      String userId,
      String role,
      ) {
    return profileRemoteDataSource.getUserInfo(
      userId,
      role,
    );

 
  }

}