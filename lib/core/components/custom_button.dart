import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    required this.ontap,
    this.isEnable = true,
  });

  final String title;
  final VoidCallback? ontap;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 50.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnable
              ? ColorsManager.primary
              : Colors.grey.shade400, // لون مختلف لما يكون مقفول
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: isEnable ? 2 : 0,
        ),
        onPressed: isEnable ? ontap : null, // يعطّل الزر
        child: Text(
          title,
          style: Theme
              .of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }}