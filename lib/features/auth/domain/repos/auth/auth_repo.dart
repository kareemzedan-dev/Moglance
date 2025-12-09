import 'package:taskly/core/errors/failures.dart';
import 'package:either_dart/either.dart';

import '../../entities/google_response_entity/google_response_entity.dart';
import '../../entities/login_response_entity/login_response_entity.dart';
import '../../entities/register_response_entity/register_response_entity.dart';
abstract class AuthRepo {
 
  Future<Either<Failures, RegisterResponseEntity>> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String role
  );
    Future<Either<Failures, LoginResponseEntity>> login(
    String email,
    String password,
        String role
  );
  Future<Either<Failures, SocialAuthResponseEntity>> googleLogin({

    required String role,
  });


  Future <Either<Failures, SocialAuthResponseEntity>> facebookLogin({
    required String role,
  });
  Future <Either<Failures, SocialAuthResponseEntity>>  appleLogin({
    required String role,
  });

}