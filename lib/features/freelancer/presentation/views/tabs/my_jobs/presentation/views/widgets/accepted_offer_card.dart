import 'package:flutter/material.dart';
import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../../features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import '../../../../find_work/presentation/views/widgets/action_row.dart';
import 'base_offer_card.dart';
import '../../../../../../../../messages/presentation/widgets/admin_message_card.dart';

class AcceptedOfferCard extends StatelessWidget {
  final OfferEntity offerEntity;

  const AcceptedOfferCard({super.key, required this.offerEntity});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BaseOfferCard(
      offerEntity: offerEntity,
      bottomWidget: ActionsRow(
        actions: [
          ActionItem(
            title: local.viewDetails,
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
        ],
      ),
      topWidget:   AdminMessageCard(
        message:
          local.checkOrderStatusMessage,
      ),
    );
  }
}
