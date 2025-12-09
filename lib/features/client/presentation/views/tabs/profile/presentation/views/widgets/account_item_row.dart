import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/app_text_styles.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class AccountItemRow extends StatelessWidget {
  const AccountItemRow({
    super.key,
    required this.image,
    required this.text,
    this.onTap,
    this.trailing,
    this.textColor,
  });

  final String image;
  final String text;
  final VoidCallback? onTap;
  final Widget? trailing; 
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Card(
            elevation: 10,
            shadowColor: Colors.transparent,
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(image, height: 16, width: 16),
              ),
            ),
          ),
            SizedBox(width: 20.w),
          Text(
            text,

            style: AppTextStyles.bold16.copyWith(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 16.sp,
            ),
          ),
          const Spacer(),
          trailing ??
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorsManager.primary,
              ), 
        ],
      ),
    );
  }
}
