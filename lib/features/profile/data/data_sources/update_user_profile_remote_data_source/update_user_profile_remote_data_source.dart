import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';

abstract class UpdateUserProfileRemoteDataSource {
  Future<Either<Failures, void>> updateUserInfo(
   String userId,
  String fullName,
  String email,
  String phoneNumber,
  String profileImage,
  ) ;
}