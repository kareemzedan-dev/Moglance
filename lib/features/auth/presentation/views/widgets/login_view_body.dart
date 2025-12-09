import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:taskly/config/l10n/app_localizations_ext.dart';
import 'package:taskly/core/components/dismissible_error_card.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/components/custom_text_field.dart';
import 'package:taskly/core/components/or_divider.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/auth/presentation/cubit/auth_states.dart';
import 'package:taskly/features/auth/presentation/cubit/auth_view_model.dart';
import 'package:taskly/features/auth/presentation/views/widgets/social_login_button.dart';
import 'package:taskly/config/l10n/app_localizations.dart';
import 'package:taskly/features/auth/presentation/views/widgets/social_login_options.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key, required this.role});
  final String role;

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  AuthViewModel authViewModel = getIt<AuthViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewModel, AuthStates>(
      listener: (context, state) {

        if (state is AuthLoginLoadingState || state is AuthGoogleLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(
              child: LoadingAnimationWidget.threeRotatingDots(
                size: 60,
                color: ColorsManager.primary,
              ),
            ),
          );
        }

        // Success states
        if (state is AuthLoginSuccessState || state is AuthGoogleSuccessState ||   state is AuthFacebookSuccessState) {
          if (mounted) Navigator.pop(context); // close dialog first
          if (mounted) {
            if (widget.role == StringsManager.freelancerRole) {
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesManager.freelancerHome, (_) => false);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesManager.clientHome, (_) => false);
            }
          }
        }

   // Error states



        if (state is AuthLoginErrorState) {
          if (mounted) Navigator.pop(context);
          final errorMessage = AppLocalizations.of(context)!.translate(
            state.error.message,
            params: state.error.params,
          );
          showTemporaryMessage(context, errorMessage, MessageType.error);
        } else if (state is AuthGoogleErrorState) {
          if (mounted) Navigator.pop(context);
          final errorMessage = AppLocalizations.of(context)!.translate(
            state.error.message,
            params: state.error.params,
          );
          showTemporaryMessage(context, errorMessage, MessageType.error);
        } else if (state is AuthFacebookErrorState) {
          if (mounted) Navigator.pop(context);
          final errorMessage = AppLocalizations.of(context)!.translate(
            state.error.message,
            params: state.error.params,
          );
          showTemporaryMessage(context, errorMessage, MessageType.error);
        }},

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: authViewModel.formKey,
            autovalidateMode: authViewModel.autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 100.w,
                    height: 100.h,

                    decoration: BoxDecoration(
                      color: ColorsManager.primary,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SvgPicture.asset(
                          Assets.assetsImagesLogo,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.welcomeBack,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 20.sp,

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                
                 CustomTextFormField(
                  prefixIcon: const Icon(CupertinoIcons.mail),
                  hintText: AppLocalizations.of(context)!.email,
                  textEditingController: authViewModel.emailController,
                  validator:
                      (p0) => p0!.isEmpty ?  AppLocalizations.of(context)!.thisFieldIsRequired : null,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (p0) {
                    authViewModel.emailController.text = p0!;
                  },
                ),
                SizedBox(height: 24.h),

          
                CustomTextFormField(
                  prefixIcon: const Icon(CupertinoIcons.lock),
                  hintText: AppLocalizations.of(context)!.password,
                  textEditingController: authViewModel.passwordController,
                  iconShow: true,
                  validator:
                      (p0) => p0!.isEmpty ? AppLocalizations.of(context)!.thisFieldIsRequired : null,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (p0) {
                    authViewModel.passwordController.text = p0!;
                  },
                ),
                // SizedBox(height: 10.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,R
                //   children: [
                //     GestureDetector(
                //       onTap:   () {
                //         Navigator.pushNamed(context, RoutesManager.forgetPasswordView);
                //       },
                //       child: Text(
                //         AppLocalizations.of(context)!.forgotPassword,
                //        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //          color: ColorsManager.primary,
                //          fontWeight: FontWeight.w600,
                //          fontSize: 14.sp,
                //        ), ),
                //     ),
                //   ],
                // ),


                SizedBox(height: 20.h),
                const OrDivider(),
                SizedBox(height: 20.h),

                SocialLoginOptions(
                    onGoogleLogin: () {
                      context.read<AuthViewModel>().googleLogin(
                          role: widget.role);
                    },
                    // onAppleLogin: () {
                    //   context.read<AuthViewModel>().appleLogin(role: widget.role);
                    // },
                    onFacebookLogin: ()
                    {
                      context.read<AuthViewModel>().facebookLogin(role: widget.role);
                    }


                ),

                SizedBox(height: 48.h),

                CustomButton(
                  title: AppLocalizations.of(context)!.login,
                  ontap: () {
                    if (authViewModel.formKey.currentState!.validate()) {
                      context.read<AuthViewModel>().loginUser(
                        email: authViewModel.emailController.text,
                        password: authViewModel.passwordController.text,
                        role: widget.role,
                      );
                    } else {
                      setState(() {
                        authViewModel.autovalidateMode =
                            AutovalidateMode.onUserInteraction;
                      });
                    }
                  },
                ),

                SizedBox(height: 10.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.dontHaveAccount,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 5.w,),
                    GestureDetector(
                      onTap: () {
                           widget.role ==  StringsManager.freelancerRole
                            ? Navigator.pushReplacementNamed(
                              context,
                              RoutesManager.register,
                              arguments:  StringsManager.freelancerRole,
                            )
                            : Navigator.pushReplacementNamed(
                              context,
                              RoutesManager.register,
                              arguments:  StringsManager.clientRole,
                            );
                      },

                      child: Text(
                        AppLocalizations.of(context)!.signUp,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorsManager.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
