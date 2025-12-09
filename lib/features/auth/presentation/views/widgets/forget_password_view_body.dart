import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/components/custom_text_field.dart';
import 'package:taskly/core/components/dismissible_error_card.dart';

import '../../cubit/forget_password_view_model/forget_password_view_model.dart';
import '../../cubit/forget_password_view_model/forget_password_view_model_states.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordViewModel, ForgetPasswordViewModelStates>(
      listener: (context, state) {
        if (state is ForgetPasswordViewModelStatesSuccess) {
          showTemporaryMessage(context, state.message, MessageType.success);
        } else if (state is ForgetPasswordViewModelStatesError) {
          showTemporaryMessage(context, state.message, MessageType.error);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 24.h),
                      Text(
                        "Don't worry, all you need to do is write your email and we will send you a password reset link.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF616A6B),
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 31.h),
                      CustomTextFormField(
                        textEditingController: emailController,
                        hintText: "Enter your email",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}').hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        isEnable: state is! ForgetPasswordViewModelStatesLoading,
                      ),
                      SizedBox(height: 30.h),
                      CustomButton(
                        title: state is ForgetPasswordViewModelStatesLoading
                            ? "Sending..."
                            : "Send Reset Link",
                        ontap: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<ForgetPasswordViewModel>().forgetPassword(
                              emailController.text.trim(),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
            // Overlay loading
            if (state is ForgetPasswordViewModelStatesLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
