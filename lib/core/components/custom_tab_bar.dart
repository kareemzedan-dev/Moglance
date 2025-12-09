import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;
  final Color? labelColor;
  final Color? unselectedLabelColor;
  final Color? indicatorColor;
  final List<int>? numbers;

  const CustomTabBar({
    super.key,
    required this.tabs,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorColor,
    this.numbers,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: labelColor ?? ColorsManager.primary,
      unselectedLabelColor: unselectedLabelColor ?? Colors.grey,
      labelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,

      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
      ),
      indicatorColor: indicatorColor ?? ColorsManager.primary,
      indicatorWeight: 4,
      tabs: List.generate(tabs.length, (index) {
        return Tab(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // اسم التاب
              Text(
                tabs[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              // البادج
              if (numbers != null && numbers!.length > index)
                Positioned(
                  top: -10.h,
                  right: -20.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 20.w,
                      minHeight: 20.h,
                    ),
                    child: Text(
                      numbers![index].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );

      }),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.h);
}
