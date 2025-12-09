import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/auth/domain/entities/google_response_entity/google_response_entity.dart';

import '../../../domain/entities/login_response_entity/login_response_entity.dart';
import '../../../domain/entities/register_response_entity/register_response_entity.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failures, RegisterResponseEntity>> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String role,
  );

  Future<Either<Failures, LoginResponseEntity>> login(String email, String password, String role);

Future<Either<Failures,SocialAuthResponseEntity>> googleLogin(String role);
Future<Either<Failures,SocialAuthResponseEntity>> facebookLogin(String role);
Future<Either<Failures,SocialAuthResponseEntity>> appleLogin(String role);
}
