import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
 
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/auth/domain/entities/google_response_entity/google_response_entity.dart';

import '../../entities/login_response_entity/login_response_entity.dart';
import '../../entities/register_response_entity/register_response_entity.dart';
import '../../repos/auth/auth_repo.dart';


 @injectable
class AuthUseCase {
  AuthRepo authRepo;

  AuthUseCase(this.authRepo);

  Future<Either<Failures, RegisterResponseEntity>> callRegister(
    String firstName,
    String lastName,
    String email,
    String password,
    String role
  ) => authRepo.register(firstName, lastName, email, password, role);
  
   Future<Either<Failures, LoginResponseEntity>> callLogin(
    String email,
    String password,
    String role
  ) => authRepo.login(email, password,role);

   Future<Either<Failures,SocialAuthResponseEntity>> callGoogleLogin(
  String role
       )=>authRepo.googleLogin(role: role);


   Future<Either<Failures,SocialAuthResponseEntity>> callFacebookLogin(
     String role
    )=>authRepo.facebookLogin(role: role);

   Future<Either<Failures,SocialAuthResponseEntity>> callAppleLogin(
  String role
   )=>authRepo.appleLogin(role: role);

}
