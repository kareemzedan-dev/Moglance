import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MessageShimmer extends StatelessWidget {
  const MessageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final isLeft = index % 2 == 0;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
            isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              if (isLeft)
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: Colors.grey.shade300,
                ),
              if (isLeft) SizedBox(width: 8.w),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: (index % 3 == 0 ? 180 : 120).w,
                  height: (index % 3 == 0 ? 50 : 35).h,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              if (!isLeft) SizedBox(width: 8.w),
              if (!isLeft)
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: Colors.grey.shade300,
                ),
            ],
          ),
        );
      },
    );
  }
}
