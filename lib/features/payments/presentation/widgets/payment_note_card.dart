

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class PaymentNoteCard extends StatelessWidget {
  const PaymentNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: ColorsManager.primary.withOpacity(0.2),
        ),
        child: Text(
            "ملاحظة: بعد إتمام التحويل، يرجى رفع صورة الإيصال أو لقطة شاشة من تطبيق البنك كإثبات للدفع." ,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}