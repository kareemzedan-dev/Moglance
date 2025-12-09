import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/l10n/app_localizations.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key,  this.description});
  final String ? description ;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        Text(
          local.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
           border: Border.all(
              color: Colors.grey.shade300,),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
             description ?? local.noDescription,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    height: 1.5,

                  ),
              softWrap: true,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
         
      ],
    );
  }
}