import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class UserInfoSectionShimmer extends StatelessWidget {
  const UserInfoSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar shimmer
          Container(
            width: 80.r,
            height: 80.r,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 20.w),

          // User info lines shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildShimmerLine(width: 160.w, height: 16.h),
                SizedBox(height: 10.h),
                _buildShimmerLine(width: 200.w, height: 14.h),
                SizedBox(height: 10.h),
                _buildShimmerLine(width: 120.w, height: 14.h),
                SizedBox(height: 10.h),
                _buildShimmerLine(width: 180.w, height: 14.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerLine({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }
}
