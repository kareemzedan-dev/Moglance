
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../domain/entities/offer_entity/offer_entity.dart';
import '../../../../../../cubit/withdraw_offer_view_model/withdraw_offer_states.dart';
import '../../../../../../cubit/withdraw_offer_view_model/withdraw_offer_view_model.dart';
import '../../../../find_work/presentation/views/widgets/action_row.dart';
import 'base_offer_card.dart';

class PendingOfferCard extends StatelessWidget {
  final OfferEntity offerEntity;

  const PendingOfferCard({super.key, required this.offerEntity});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BaseOfferCard(

      offerEntity: offerEntity,
      bottomWidget: BlocBuilder<WithdrawOfferViewModel, WithdrawOfferStates>(
        builder: (context, state) {
          return ActionsRow(actions: [
            ActionItem(
              title:local.viewDetails,
              icon: Icons.remove_red_eye_outlined,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesManager.offerDetailsView,
                  arguments: {
                    'orderId': offerEntity.orderId,
                  },
                );
              },
            ),
            ActionItem(
              title: state is WithdrawOfferStatesLoading ?local.withdrawn : local.withdraw_offer,
              icon: Icons.remove_circle_outline,
              onTap: state is WithdrawOfferStatesLoading
                  ? null
                  : () {
                context.read<WithdrawOfferViewModel>().withdrawOffer(
                    offerEntity.id, offerEntity.orderId);
              },
            ),
          ]);
        },
      ),
    );
  }
}
