import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../repos/freelancer_order_repo/subscribe_to_public_orders_repo/subscribe_to_public_orders_repo.dart';

@injectable
class SubscribeToPublicOrdersUseCase {
  final SubscribeToPublicOrdersRepo subscribeToPublicOrdersRepo;

  SubscribeToPublicOrdersUseCase({required this.subscribeToPublicOrdersRepo});



  Stream<List<OrderEntity>>  subscribeToPublicOrders(

      String freelancerId
      ) {
    return subscribeToPublicOrdersRepo.subscribeToPublicOrders(freelancerId);
  }
}
