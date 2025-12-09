import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/features/welcome/presentation/cubit/welcome_states.dart';
import 'package:taskly/config/l10n/app_localizations.dart';

import '../../../../../core/utils/strings_manager.dart';

class AuthActionSection extends StatelessWidget {
  final UserRole selectedRole;

  const AuthActionSection({super.key, required this.selectedRole});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomButton(
            title:
                selectedRole == UserRole.freelancer
                    ? AppLocalizations.of(context)!.createFreelancerAccount
                    : AppLocalizations.of(context)!.createClientAccount,
            ontap: () {
              Navigator.pushNamed(
                context,
                RoutesManager.register,
                arguments:
                    selectedRole == UserRole.freelancer
                        ?  StringsManager.freelancerRole
                        : StringsManager.clientRole,
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.alreadyHaveAccount,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(width: 5.w),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesManager.login,
                    arguments:
                        selectedRole == UserRole.freelancer
                            ?  StringsManager.freelancerRole
                            : StringsManager.clientRole,
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
