import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/colors_manger.dart';
import 'package:taskly/features/profile/presentation/widgets/user_info_section.dart';

class ReviewsCard extends StatelessWidget {
  const ReviewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height:  MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(16.r),topRight:Radius.circular(16.r)),)
    ,  child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            elevation: 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: ColorsManager.primary),
              ),
              child: const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      UserInfoSection(isFreelancer: true, photoSizeSelected: true,),
                    ],)
                ],
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}
