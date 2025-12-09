import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/components/custom_text_field.dart';
import 'package:taskly/core/components/dismissible_error_card.dart';
import 'package:taskly/features/auth/presentation/cubit/change_password_view_model/change_password_view_model.dart';
import 'package:taskly/features/auth/presentation/cubit/change_password_view_model/change_password_view_model_states.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key});

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocConsumer<ChangePasswordViewModel, ChangePasswordViewModelStates>(
      listener: (context, state) {
        if (state is ChangePasswordViewModelSuccessState) {
          Navigator.pop(context);
          showTemporaryMessage(context, local.passwordChangedSuccess, MessageType.success);
        } else if (state is ChangePasswordViewModelErrorState) {
          showTemporaryMessage(context, state.message, MessageType.error);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          local.changePassword,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          local.changePasswordDesc,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        CustomTextFormField(
                          textEditingController: oldPasswordController,
                          hintText: local.enterOldPassword,
                          iconShow: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return local.enterOldPassword;
                            }
                            return null;
                          },
                          isEnable: state is! ChangePasswordViewModelLoadingState,
                        ),
                        SizedBox(height: 20.h),
                        CustomTextFormField(
                          textEditingController: newPasswordController,
                          hintText: local.enterNewPassword,
                          iconShow: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return local.enterNewPassword;
                            } else if (value.length < 6) {
                              return local.passwordValidation;
                            }
                            return null;
                          },
                          isEnable: state is! ChangePasswordViewModelLoadingState,
                        ),

                        SizedBox(height: 100.h),
                        CustomButton(
                          title: local.changePassword,
                          ontap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<ChangePasswordViewModel>().changePassword(
                                oldPasswordController.text,
                                newPasswordController.text,
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
            ),
            // Overlay loading
            if (state is ChangePasswordViewModelLoadingState)
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
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}