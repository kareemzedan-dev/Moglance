import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/core/components/custom_app_bar.dart';
import 'package:taskly/features/auth/presentation/views/widgets/forget_password_view_body.dart';

import '../../../../core/di/di.dart';
import '../cubit/forget_password_view_model/forget_password_view_model.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar( title: "Forget Password" , ),
      backgroundColor: Colors.white,
      body: BlocProvider(
          create:  (context) =>  getIt<ForgetPasswordViewModel>(),
          child: const ForgetPasswordViewBody()),
    );
  }
}