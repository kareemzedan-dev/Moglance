import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/components/custom_button.dart';

import '../../../../../core/components/custom_text_field.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24),
            Text(
              "قم بإنشاء كلمة مرور جديدة لتسجيل الدخول",

              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF616A6B),
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
              ),
            ),

            SizedBox(height: 34),
            CustomTextFormField(
              hintText: "كلمة المرور",
              keyboardType: TextInputType.visiblePassword,
              iconShow: true,
            ),
            SizedBox(height: 24),
            CustomTextFormField(
              hintText: "تاكيد كلمة المرور",
              keyboardType: TextInputType.visiblePassword,
              iconShow: true,
            ),
            SizedBox(height: 36),
            CustomButton(title: "إنشاء كلمة مرور جديدة", ontap: () {}),
          ],
        ),
      ),
    );
  }
}
