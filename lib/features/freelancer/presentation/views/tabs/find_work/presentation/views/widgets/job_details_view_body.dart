import 'package:flutter/material.dart';
import 'package:taskly/config/routes/routes_manager.dart';
import 'package:taskly/core/components/custom_button.dart';
import 'package:taskly/core/helper/date_time_formatter.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/widgets/about_job_section.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/shared/presentation/views/widgets/attachments_section.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/widgets/client_details_section.dart';
import 'package:taskly/features/shared/presentation/views/widgets/description_section.dart';
import 'package:taskly/features/shared/presentation/views/widgets/job_header_section.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';

class JobDetailsViewBody extends StatelessWidget {
  const JobDetailsViewBody({super.key,required this.orderEntity});
  final OrderEntity orderEntity ;


  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:   [
                    JobHeader(title: orderEntity.title ,category: orderEntity.category!,date: orderEntity.createdAt.toTimeAgo(context),),
                    const Divider(thickness: 1, color: Colors.grey),
                    DescriptionSection(description:orderEntity.description ,),
                    const Divider(thickness: 1, color: Colors.grey),
                    ClientDetailsSection(userId: orderEntity.clientId,),

                    const Divider(thickness: 1, color: Colors.grey),
                    AttachmentsSection(attachmentEntity: orderEntity.attachments,isFreelancer: true,),
                    const Divider(thickness: 1, color: Colors.grey),
                    AboutJobSection( order: orderEntity),
                  ],
                ),
              ),
            ),
          ),
          // CustomButton(title: local.send_offer , ontap: () {
          //   Navigator.pushNamed(context, RoutesManager.sendOfferView, arguments:orderEntity);
          // }),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

