import 'package:flutter/material.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/views/widgets/action_button.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../../../../../../config/l10n/app_localizations.dart';
import '../../../../../../../../../config/routes/routes_manager.dart';
import '../../../../../../../../../core/cache/shared_preferences.dart';
import '../../../../../../../../../core/utils/strings_manager.dart';

class OfferActions extends StatelessWidget {
 const OfferActions({
    super.key,
    required this.offerId,
    required this.onAcceptOffer,
    required this.userName,
    required this.userImage,
    required this.order,
    required this.currentUserId,
    required this.receiverId,
  });

  final String offerId;
  final void Function() onAcceptOffer;
  final String userName;
  final String userImage;
  final OrderEntity order;

  final String currentUserId;
  final String receiverId;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            text:local.start_chat,
            icon: Icons.chat,
            color: Colors.blue,
            filled: false,
            onTap: () {
              Navigator.pushNamed(context, RoutesManager.chatView, arguments: {

                "currentUserName": SharedPrefHelper.getString(StringsManager.fullNameKey),
                "receiverName": userName,
                "currentUserAvatar": SharedPrefHelper.getString(StringsManager.profileImageKey),
                "receiverAvatar": userImage,


                "order": order,
                "currentUserId": currentUserId,
                "receiverId": receiverId,
              });
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ActionButton(
            text: local.accept_offer,
            icon: Icons.check,
            color: Colors.green,
            filled: true,
            onTap: onAcceptOffer,
          ),
        ),
      ],
    );
  }
}
