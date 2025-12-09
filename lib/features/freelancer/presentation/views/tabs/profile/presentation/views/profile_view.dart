import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/core/components/circle_icon_button.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/profile/presentation/views/widgets/freelancer_profile_view_body.dart';

import '../../../../../../../../config/l10n/app_localizations.dart';

class FreelancerProfileViewTab extends StatelessWidget {
  const FreelancerProfileViewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,

        title: Text(
          local.profile,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
        elevation: 0,
        shape: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CircularIconButton(image: Assets.assetsImagesSettings),
          ),
        ],
      ),

      body: const FreelancerProfileViewBody(),
    );
  }
}
