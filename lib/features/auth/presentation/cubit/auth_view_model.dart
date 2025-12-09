import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';

import 'package:taskly/features/auth/presentation/cubit/auth_states.dart';

import '../../domain/use_cases/auth/auth_use_case.dart';
@injectable
class AuthViewModel extends Cubit<AuthStates> {
  AuthViewModel({required this.authUseCase})
      : super(AuthRegisterInitialState());

  final AuthUseCase authUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode? autovalidateMode = AutovalidateMode.disabled;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();

  // ===================== REGISTER =====================
  void registerUser({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? role,
  }) async {
    try {
      emit(AuthRegisterLoadingState());
      final result = await authUseCase.callRegister(
        firstName!,
        lastName!,
        email!,
        password!,
        role!,
      );
      result.fold(
            (failure) => emit(AuthRegisterErrorState(failure)),
            (registerResponse) => emit(AuthRegisterSuccessState(registerResponse)),
      );
    } catch (e) {
      emit(AuthRegisterErrorState(ServerFailure(e.toString())));
    }
  }

  // ===================== LOGIN =====================
  void loginUser({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      emit(AuthLoginLoadingState());
      final result = await authUseCase.callLogin(email, password, role);
      result.fold(
            (failure) => emit(AuthLoginErrorState(failure)),
            (user) => emit(AuthLoginSuccessState(user)),
      );
    } catch (e) {
      emit(AuthLoginErrorState(ServerFailure(e.toString())));
    }
  }

  // ===================== GOOGLE =====================
  void googleLogin({required String role}) async {
    try {
      emit(AuthGoogleLoadingState());
      final result = await authUseCase.callGoogleLogin(role);
      result.fold(
            (failure) => emit(AuthGoogleErrorState(failure)),
            (googleResponse) => emit(AuthGoogleSuccessState(googleResponse)),
      );
    } catch (e) {
      emit(AuthGoogleErrorState(ServerFailure(e.toString())));
    }
  }

  // ===================== FACEBOOK =====================
  void facebookLogin({required String role}) async {
    try {
      emit(AuthFacebookLoadingState());
      final result = await authUseCase.callFacebookLogin(role);
      result.fold(
            (failure) => emit(AuthFacebookErrorState(failure)),
            (facebookResponse) => emit(AuthFacebookSuccessState( facebookResponse)),
      );
    } catch (e) {
      emit(AuthFacebookErrorState(ServerFailure(e.toString())));
    }
  }

  // ===================== APPLE =====================
  void appleLogin({required String role}) async {
    try {
      emit(AuthAppleLoadingState());
      final result = await authUseCase.callAppleLogin(role);
      result.fold(
            (failure) => emit(AuthAppleErrorState(failure)),
            (appleResponse) => emit(AuthAppleSuccessState(appleResponse)),
      );
    } catch (e) {
      emit(AuthAppleErrorState(ServerFailure(e.toString())));
    }
  }

  // ===================== LOGOUT =====================
  // void logout() async {
  //   try {
  //     emit(AuthLogoutLoadingState());
  //     final result = await authUseCase.callLogout();
  //     result.fold(
  //           (failure) => emit(AuthLogoutErrorState(failure)),
  //           (_) => emit(AuthLogoutSuccessState()),
  //     );
  //   } catch (e) {
  //     emit(AuthLogoutErrorState(ServerFailure(e.toString())));
  //   }
  // }

  // ===================== VALIDATION HELPERS =====================
  bool validateForm() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      autovalidateMode = AutovalidateMode.always;
      emit(AuthRegisterInitialState());
    }
    return isValid;
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    return super.close();
  }
}
