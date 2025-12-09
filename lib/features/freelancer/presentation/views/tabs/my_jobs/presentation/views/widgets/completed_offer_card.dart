import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../client/presentation/views/tabs/my_jobs/presentation/view_model/update_offer_status_view_model/update_offer_status_view_model.dart';
import 'base_offer_card.dart';

class CompletedOfferCard extends StatelessWidget {
  final OfferEntity offerEntity;

  const CompletedOfferCard({super.key, required this.offerEntity});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BaseOfferCard(
      offerEntity: offerEntity,
      topWidget: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green, width: 1),
          ),
          child:   Text(
           local.offerCompletedMessage,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      bottomWidget:
      GestureDetector(
        onTap: () {
          context.read<UpdateOfferStatusViewModel>().updateOfferStatus(offerEntity.id, "Deleted");
        },
        child: Container(
          width: double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: Theme.of(context).scaffoldBackgroundColor ,
            border: Border.all(color: Colors.red, width: 2.w),
          ),
          child:   Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.close, color: Colors.red),
                SizedBox(width: 6),
                Text(
                 local.delete_this_offer,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}