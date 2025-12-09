
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';


class ActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final bool filled;
  final VoidCallback? onTap;

  const ActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.filled,
      this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h), // padding responsive
        decoration: BoxDecoration(
          color: filled ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: filled ? null : Border.all(color: color, width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: filled ? ColorsManager.white : color, size: 20.sp),
            SizedBox(width: 5.w),
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: filled ? ColorsManager.white : color,
                  fontSize: 14.sp, // responsive font
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}