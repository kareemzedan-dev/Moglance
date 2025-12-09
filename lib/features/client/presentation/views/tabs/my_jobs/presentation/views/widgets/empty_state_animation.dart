import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../../../../../../core/utils/colors_manger.dart';

class EmptyStateAnimation extends StatelessWidget {
  final String animationPath;
  final String message;

  const EmptyStateAnimation({
    super.key,
    required this.animationPath,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorsManager.primary.withValues(alpha: 0.2),

              shape: BoxShape.circle,
            ),
            child: Lottie.asset(
              animationPath,
              width: 200.w,
              height: 200.h,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style:  Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey,

              fontSize: 18.sp,
              fontWeight: FontWeight.bold

            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
