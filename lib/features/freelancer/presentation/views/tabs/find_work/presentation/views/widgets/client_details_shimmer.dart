import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientDetailsShimmer extends StatelessWidget {
  const ClientDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Container(
            height: 16.h,
            width: 120.w,
            color: Colors.white,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              // Avatar shimmer
              Container(
                width: 60.w,
                height: 60.w,
                decoration:   BoxDecoration(
                  shape: BoxShape.circle,
                  color:Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14.h,
                    width: 100.w,
                    color: Theme.of(context).scaffoldBackgroundColor
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 12.h,
                    width: 150.w,
                    color: Theme.of(context).scaffoldBackgroundColor),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
