import 'package:flutter/material.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/views/widgets/custom_action_container.dart';

class ActionsRow extends StatelessWidget {
  final OrderEntity? order;
  final List<ActionItem> actions;

  const ActionsRow({
    super.key,
      this.order,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((action) {
        return CustomActionContainer(
          title: action.title,
          icon: action.icon,
          isOffer: action.isOffer,
          onTap: action.onTap,
        );
      }).toList(),
    );
  }
}

class ActionItem {
  final String title;
  final IconData icon;
  final bool isOffer;
  final VoidCallback? onTap;

  ActionItem({
    required this.title,
    required this.icon,
    this.isOffer = false,
    required this.onTap,
  });
}
