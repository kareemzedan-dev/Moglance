import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/features/auth/presentation/cubit/auth_view_model.dart';
import 'package:taskly/features/auth/presentation/views/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key, required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>  getIt<AuthViewModel>(),
          child: RegisterViewBody(role: role),
        ),
      ),
    );
  }
}
