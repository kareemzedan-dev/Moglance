import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class CustomActionContainer extends StatelessWidget {
  const CustomActionContainer({
    super.key,
    required this.title,
    required this.icon,
    this.isOffer = false,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final bool isOffer;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isWithdraw = title.toLowerCase().contains('withdraw');

    final containerColor = isWithdraw ? Colors.white : (isOffer ? ColorsManager.primary : Colors.white);
    final iconColor = isWithdraw ? Colors.red : (isOffer ? Colors.white : ColorsManager.primary);
    final textColor = isWithdraw ? Colors.red : (isOffer ? Colors.white : ColorsManager.primary);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2.w),
          color: containerColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor),
              SizedBox(width: 5.w),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
