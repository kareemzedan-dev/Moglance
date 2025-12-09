import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskly/core/utils/assets_manager.dart';

import '../../../../../config/l10n/app_localizations.dart';
import '../../../../attachments/data/models/attachments_dm/attachments_dm.dart';
import '../../../../attachments/presentation/widgets/attachment_card_viewer_list_view.dart';

class AttachmentsSection extends StatelessWidget {
  const AttachmentsSection({
    super.key,
    required this.attachmentEntity,
    required this.isFreelancer,
  });

  final List<AttachmentModel> attachmentEntity;
  final bool isFreelancer;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          local.attachments,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,

          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200,width: 1),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),

          child: attachmentEntity.isEmpty ? Center(child: Column(
            children: [
              Image.asset(Assets.assetsImagesempty,height: 130.h,),
              SizedBox(height: 20.h),
              Text("لا يوجد مرفقات",style:  Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: Colors.black,

              ),),
            ],
          )) : AttachmentCardViewerListView(
            attachmentEntity: attachmentEntity,
            isFreelancer: isFreelancer
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
