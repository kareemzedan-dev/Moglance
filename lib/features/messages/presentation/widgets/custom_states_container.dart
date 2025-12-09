import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class CustomStatesContainer extends StatelessWidget {
  const CustomStatesContainer({super.key, required this.state});
  final String state;

  @override
  Widget build(BuildContext context) {
    return        Container(
                        height: 18.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          color: ColorsManager.secondary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                          ),
                          child: Center(
                            child: Text(
                            state,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                                    color: ColorsManager.primary,
                              ),
                            ),
                          ),
                        ),
                      );
  }
}