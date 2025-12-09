import 'package:taskly/core/errors/failures.dart';

import '../../domain/entities/google_response_entity/google_response_entity.dart';
import '../../domain/entities/login_response_entity/login_response_entity.dart';
import '../../domain/entities/register_response_entity/register_response_entity.dart';

class AuthStates {}

class AuthRegisterInitialState extends AuthStates {}

class AuthRegisterLoadingState extends AuthStates {}

class AuthRegisterSuccessState extends AuthStates {
  final RegisterResponseEntity user;

  AuthRegisterSuccessState(this.user);
}

class AuthRegisterErrorState extends AuthStates {
  final Failures error;

  AuthRegisterErrorState(this.error);
}

class AuthLoginInitialState extends AuthStates {}

class AuthLoginLoadingState extends AuthStates {}

class AuthLoginSuccessState extends AuthStates {
  final LoginResponseEntity user;

  AuthLoginSuccessState(this.user);
}

class AuthLoginErrorState extends AuthStates {
  final Failures error;

  AuthLoginErrorState(this.error);
}

class AuthGoogleInitialState extends AuthStates {}

class AuthGoogleLoadingState extends AuthStates {}

class AuthGoogleSuccessState extends AuthStates {
  final SocialAuthResponseEntity user;

  AuthGoogleSuccessState(this.user);
}

class AuthGoogleErrorState extends AuthStates {
  final Failures error;

  AuthGoogleErrorState(this.error);
}

class AuthLogoutInitialState extends AuthStates {}

class AuthLogoutLoadingState extends AuthStates {}

class AuthLogoutSuccessState extends AuthStates {}

class AuthLogoutErrorState extends AuthStates {
  final Failures error;

  AuthLogoutErrorState(this.error);
}

class AuthFacebookInitialState extends AuthStates {}

class AuthFacebookLoadingState extends AuthStates {}

class AuthFacebookSuccessState extends AuthStates {
  final SocialAuthResponseEntity user;

  AuthFacebookSuccessState(this.user);
}

class AuthFacebookErrorState extends AuthStates {
  final Failures error;

  AuthFacebookErrorState(this.error);
}

class AuthAppleInitialState extends AuthStates {}

class AuthAppleLoadingState extends AuthStates {}

class AuthAppleSuccessState extends AuthStates {
  final SocialAuthResponseEntity user;

  AuthAppleSuccessState(this.user);
}

class AuthAppleErrorState extends AuthStates {
  final Failures error;

  AuthAppleErrorState(this.error);
}
