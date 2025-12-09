import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class BankInfoRow extends StatelessWidget {
  final String label;
  final String number;
  final VoidCallback? onCopy;
  final String? assetPath;

  const BankInfoRow({
    super.key,
    required this.label,
    required this.number,
    this.onCopy,
    this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        if (assetPath != null)
          Image.asset(
            assetPath!,
            height: 24.h,
            width: 24.w,
          ),
        if (assetPath != null) SizedBox(width: 12.w),


        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                number,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
                softWrap: true,
              ),
            ],
          ),
        ),

        SizedBox(width: 12.w),


        GestureDetector(
          onTap: onCopy,
          child: Container(
            padding: EdgeInsets.all(4.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: ColorsManager.primary,
            ),
            child: Icon(
              Icons.copy,

              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
