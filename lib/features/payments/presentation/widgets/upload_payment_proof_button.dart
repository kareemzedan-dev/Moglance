import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly/core/utils/colors_manger.dart';

import '../../../../config/l10n/app_localizations.dart';

class UploadPaymentProofButton extends StatelessWidget {
  const UploadPaymentProofButton({super.key, required this.onTap});

 final VoidCallback onTap;
 

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: ColorsManager.primary),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.upload,
              size: 20.sp,
              color: ColorsManager.primary,
            ),
            SizedBox(width: 10.w),
            Text(
             local.upload_payment_proof,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: ColorsManager.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
