import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';

class InputProposalPrice extends StatelessWidget {
  final String hint;
  final String selectedValue;
  final ValueChanged<String?> onChanged;
  final TextEditingController? controller;
  final String? errorText; // رسالة الخطأ

  const InputProposalPrice({
    super.key,
    required this.hint,
    required this.selectedValue,
    required this.onChanged,
    required this.controller,
    this.errorText,  
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2.w,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (val) {
                onChanged(val);
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                errorText: errorText,  
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Text(
              local.sar  ,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: ColorsManager.primary,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
