import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyMessagesWidget extends StatelessWidget {
  const EmptyMessagesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            "assets/lotties/Not_found.json", 
            width: 250.w,
            height: 250.h,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          "No Conversations yet",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
        ),
      ],
    );
  }
}
