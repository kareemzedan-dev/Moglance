import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';

import '../../../../config/l10n/app_localizations.dart';

class SecurePaymentBanner extends StatelessWidget {
  const SecurePaymentBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: ColorsManager.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.verified_user_rounded,
            color: Colors.green.shade400,
            size: 24.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
           local.secure_payment_note,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
