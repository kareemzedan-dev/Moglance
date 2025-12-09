import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/features/welcome/presentation/cubit/welcome_states.dart';
import 'package:taskly/features/welcome/presentation/views/widgets/role_box.dart';
import 'package:taskly/config/l10n/app_localizations.dart';

class RoleSelectionRow extends StatelessWidget {
  final UserRole? selectedRole;
  final Function(UserRole) onRoleSelected;

  const RoleSelectionRow({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RoleBox(
            image: Assets.assetsImagesFreelancer,
            title: AppLocalizations.of(context)!.freelancerTitle,
            subtitle: AppLocalizations.of(context)!.freelancerSubtitle,
            isSelected: selectedRole == UserRole.freelancer,
            onTap: () => onRoleSelected(UserRole.freelancer),
          ),
          RoleBox(
            image: Assets.assetsImagesClient,
            title: AppLocalizations.of(context)!.clientTitle,
            subtitle: AppLocalizations.of(context)!.clientSubtitle,
            isSelected: selectedRole == UserRole.client,
            onTap: () => onRoleSelected(UserRole.client),
          ),
        ],
      ),
    );
  }
}
