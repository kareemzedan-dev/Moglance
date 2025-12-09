import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class FreelancerWorkCardShimmer extends StatelessWidget {
  const FreelancerWorkCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(

                border: Border.all(color: Colors.grey.shade300, width: 2.w),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HeaderRow
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(width: 100.w, height: 14.h, color: Theme.of(context).scaffoldBackgroundColor),
                          Container(width: 24.w, height: 24.h, color: Theme.of(context).scaffoldBackgroundColor),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      // Title
                      Container(width: 180.w, height: 18.h, color: Theme.of(context).scaffoldBackgroundColor),
                      SizedBox(height: 5.h),
                      // Category chip
                      Container(width: 100.w, height: 28.h, color: Theme.of(context).scaffoldBackgroundColor),
                      SizedBox(height: 16.h),
                      // Description
                      Container(width: double.infinity, height: 40.h, color: Theme.of(context).scaffoldBackgroundColor),
                      SizedBox(height: 16.h),
                      // Delivery Info
                      Container(width: 120.w, height: 14.h, color: Theme.of(context).scaffoldBackgroundColor),
                      SizedBox(height: 16.h),
                      // Actions buttons
                      Row(
                        children: [
                          Container(width: 100.w, height: 32.h, color:Theme.of(context).scaffoldBackgroundColor),
                           const Spacer(),
                          Container(width: 100.w, height: 32.h, color: Theme.of(context).scaffoldBackgroundColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
