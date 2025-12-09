import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingBreakdown extends StatelessWidget {
  final Map<int, int> ratings; // key = النجوم، value = عدد الناس
  final int total;

  const RatingBreakdown({
    super.key,
    required this.ratings,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ratings.keys.toList().reversed.map((star) {
        final count = ratings[star] ?? 0;
        final percentage = total > 0 ? count / total : 0.0;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            children: [
              // عدد النجوم (مثلاً 5★)
              SizedBox(
                width: 45.w,
                child: Text(
                  "$star ★",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                      ),
                ),
              ),

              // Progress bar
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    value: percentage,
                    minHeight: 10.h,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.amber,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              // العدد
              Text(
                "$count",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 13.sp,
                    ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
