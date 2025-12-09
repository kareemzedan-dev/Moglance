import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/config/theme/app_theme.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class HireMethodCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final String? badge;

  const HireMethodCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160.w,

        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? ColorsManager.primary.withOpacity(0.1)
                  : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? ColorsManager.primary : Colors.grey.shade300,
            width: 2.w,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor:
                  isSelected
                      ? ColorsManager.primary.withOpacity(0.2)
                      : Colors.grey.shade200,
              child: Icon(
                icon,
                size: 28.sp,
                color: isSelected ? ColorsManager.primary : Colors.grey[700],
              ),
            ),
            SizedBox(height: 12.h),

            (badge != null)
                ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 192, 16),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    badge!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                : Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    "Public",
                    style: TextStyle(
                      color: Colors.transparent,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ), // this container for design only (not working)

            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,

              overflow: TextOverflow.visible,
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: isSelected ? ColorsManager.primary : Colors.black87,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              subtitle,

              textAlign: TextAlign.center,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
