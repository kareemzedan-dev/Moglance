import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';

import '../../domain/entities/user_info_entity/user_info_entity.dart';

abstract class ProfileRemoteDataSource {
    Future<Either<Failures,UserInfoEntity>> getUserInfo(
        String userId,
        String role,
        );
}