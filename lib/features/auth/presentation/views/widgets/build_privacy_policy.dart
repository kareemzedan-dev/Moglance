import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/config/l10n/app_localizations.dart';

class PrivacyPolicyWithCheck extends FormField<bool> {
  PrivacyPolicyWithCheck({super.key})
      : super(
          initialValue: false,
    validator: (value) {
      if (value == false) {
        return "يجب الموافقة على الشروط والأحكام قبل المتابعة*";
      }
      return null;
    },
          builder: (state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: state.value ?? false,
                      activeColor: ColorsManager.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: BorderSide(
                        color: state.hasError ? Colors.red : Colors.grey,
                        width: 2,
                      ),
                      onChanged: (value) {
                        state.didChange(value);
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(state.context)!.privacyPolicyAgreement,
                              style: Theme.of(state.context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorsManager.black,
                                fontSize: 14.sp,
                                ),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(state.context)!.privacyPolicy,
                              style: Theme.of(state.context).textTheme.bodyMedium?.copyWith(
                                    color: ColorsManager.primary,
                                    fontSize: 14.sp,
                                  ),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(state.context)!.termsAgreement,
                              style: Theme.of(state.context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorsManager.black,
                                fontSize: 14.sp,
                                ),
                            ),
                            TextSpan(
                              text: AppLocalizations.of(state.context)!.termsOfUse,
                              style: Theme.of(state.context).textTheme.bodyMedium?.copyWith(
                                    color: ColorsManager.primary,
                                    fontSize: 14.sp,
                                  ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                if (state.hasError)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, left: 8.w),
                    child: Text(
                      state.errorText!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            );

          },
        );
}
