import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class PriceDurationSection extends StatelessWidget {
  final String price;
  final String duration;

  const PriceDurationSection({
    super.key,
    required this.price,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: ColorsManager.primary,
              width: 1.w,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                price,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          duration,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
