import 'package:flutter/material.dart';
import 'package:taskly/core/components/custom_app_bar.dart';
import 'package:taskly/features/auth/presentation/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});
  static const String reset_password = '/reset-password';
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: CustomAppBar(   title: "كلمة مرور جديدة" , ),
      backgroundColor: Colors.white,
      body:ResetPasswordViewBody() ,
    );
  }
}