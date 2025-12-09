import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskly/core/di/di.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/update_offer_status_view_model/update_offer_status_view_model.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:taskly/features/freelancer/presentation/cubit/withdraw_offer_view_model/withdraw_offer_view_model.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/my_jobs/presentation/views/widgets/pending_offer_card.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/my_jobs/presentation/views/widgets/rejected_offer_card.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/my_jobs/presentation/views/widgets/tracking_offer_card.dart';

import 'accepted_offer_card.dart';
import 'completed_offer_card.dart';


class TrackingOffersListView extends StatelessWidget {
  TrackingOffersListView(
      {super.key, required this.offer, this.isPending = false,this.isAccepted = false, this.isRejected = false, this.isCompleted = false,});
  List<OfferEntity> offer;
  bool isPending;
  bool isAccepted;
  bool isRejected ;
  bool isCompleted;
  Widget getOfferCard(OfferEntity offer) {
    if (isPending) {
      return PendingOfferCard(offerEntity: offer);
    } else if (isAccepted) {
      return AcceptedOfferCard(offerEntity: offer);
    } else if (isRejected) {
      return RejectedOfferCard(offerEntity: offer);
    } else if (isCompleted) {
      return CompletedOfferCard(offerEntity: offer);
    }
    return PendingOfferCard(offerEntity: offer);
  }


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: offer.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
            color: Colors.grey,
          );
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => getIt<WithdrawOfferViewModel>()),
                BlocProvider(create: (context) => getIt<UpdateOfferStatusViewModel>()),
              ],
              child: getOfferCard(offer[index]),
            ),
          );
        }
    );
  }
}
