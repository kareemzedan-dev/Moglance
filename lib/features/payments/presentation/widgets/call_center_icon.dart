import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/assets_manager.dart';
import 'package:taskly/core/utils/colors_manger.dart';

class CallCenterIcon extends StatelessWidget {
  const CallCenterIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60.r),
        color: ColorsManager.primary.withOpacity(0.2),
      ),
      child: Image.asset(
        Assets.assetsImagesCallCenterService16343600,
        height: 30.h,
        width: 30.w,
      ),
    );
  }
}