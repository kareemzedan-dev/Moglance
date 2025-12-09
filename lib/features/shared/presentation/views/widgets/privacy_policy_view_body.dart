import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/l10n/app_localizations.dart';

class PrivacyPolicyViewBody extends StatelessWidget {
  const PrivacyPolicyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!; // استخدام S.of(context)
    final TextStyle titleStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp,);

    final TextStyle bodyStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(  height: 1.5,fontSize: 14.sp,);

    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all( width: 2.w),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(local.privacyPolicy, style: titleStyle),
                  SizedBox(height: 12.h),
                  Text(
                    local.privacyPolicyWelcome,
                    style: bodyStyle,
                  ),
                  SizedBox(height: 20.h),

                  Text(local.informationWeCollect, style: titleStyle),
                  SizedBox(height: 8.h),
                  Text(
                    local.informationWeCollectDesc,
                    style: bodyStyle,
                  ),
                  SizedBox(height: 20.h),

                  Text(local.howWeUseInfo, style: titleStyle),
                  SizedBox(height: 8.h),
                  Text(
                    local.howWeUseInfoDesc,
                    style: bodyStyle,
                  ),
                  SizedBox(height: 20.h),

                  Text(local.sharingData, style: titleStyle),
                  SizedBox(height: 8.h),
                  Text(
                    local.sharingDataDesc,
                    style: bodyStyle,
                  ),
                  SizedBox(height: 20.h),

                  Text(local.dataSecurity, style: titleStyle),
                  SizedBox(height: 8.h),
                  Text(
                    local.dataSecurityDesc,
                    style: bodyStyle,
                  ),
                  SizedBox(height: 20.h),

                  Text(local.yourRights, style: titleStyle),
                  SizedBox(height: 8.h),
                  Text(
                    local.yourRightsDesc,
                    style: bodyStyle,
                  ),
                  SizedBox(height: 20.h),

                  Text(local.cookiesTracking, style: titleStyle),
                  SizedBox(height: 8.h),
                  Text(
                    local.cookiesTrackingDesc,
                    style: bodyStyle,
                  ),
                  SizedBox(height: 20.h),

                  Text(local.policyUpdates, style: titleStyle),
                  SizedBox(height: 8.h),
                  Text(
                    local.policyUpdatesDesc,
                    style: bodyStyle,
                  ),
                  SizedBox(height: 20.h),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}