import 'package:flutter/material.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'base_offer_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/di/di.dart';
import '../../../../../../../../../features/client/presentation/views/tabs/my_jobs/presentation/view_model/update_offer_status_view_model/update_offer_status_view_model.dart';

class RejectedOfferCard extends StatelessWidget {
  final OfferEntity offerEntity;

  const RejectedOfferCard({super.key, required this.offerEntity});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BaseOfferCard(
      offerEntity: offerEntity,
      bottomWidget: GestureDetector(
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
