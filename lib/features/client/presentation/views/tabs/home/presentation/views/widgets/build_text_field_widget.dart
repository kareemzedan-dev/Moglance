import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../core/utils/colors_manger.dart';

TextFormField buildTextField(
    String? hintText,
    int maxLines,
    TextEditingController controller,
    void Function(String?)? onsaved,
    ) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines,
    onSaved: onsaved,
    style: TextStyle(fontSize: 14.sp,  ),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: ColorsManager.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
    ),
  );
}
