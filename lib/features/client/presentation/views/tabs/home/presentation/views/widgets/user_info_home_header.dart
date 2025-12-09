import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/features/reviews/presentation/widgets/user_avatar.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../core/cache/shared_preferences.dart';
import '../../../../../../../../../core/utils/strings_manager.dart';

class UserInfoHomeHeader extends StatelessWidget {
  UserInfoHomeHeader({
    super.key,
  });

  final String? fullName =
      SharedPrefHelper.getString(StringsManager.fullNameKey)!;
  final String? imageUrl =
      SharedPrefHelper.getString(StringsManager.profileImageKey)  ;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              local!.hiUser(fullName ?? ""),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            Text(
              local.welcomeTaskly,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 18.sp,
              ),
            ),

          ],
        ),
        UserAvatar(
          userName: fullName,
          imagePath: imageUrl,
          radius: 24.r,
        )
      ],
    );
  }
}
