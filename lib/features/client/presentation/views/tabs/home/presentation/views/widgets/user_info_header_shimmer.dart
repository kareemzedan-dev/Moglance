
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class UserInfoHomeHeaderShimmer extends StatelessWidget {
  const UserInfoHomeHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 120.w,
                height: 16.h,
              ),
              SizedBox(height: 8.h),
              Container(
                width: 180.w,
                height: 20.h,
              ),
            ],
          ),
          Container(
            width: 60.r,
            height: 60.r,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}