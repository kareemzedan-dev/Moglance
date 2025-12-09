import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';

import '../../entities/user_info_entity/user_info_entity.dart';

abstract class ProfileRepo {
    Future<Either<Failures,UserInfoEntity>> getUserInfo(
        String userId,
        String role,
        );
}