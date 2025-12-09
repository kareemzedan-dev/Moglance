import 'package:injectable/injectable.dart';

import '../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../repos/freelancer_order_repo/subscribe_to_private_orders_repo/subscribe_to_private_orders_repo.dart';
@injectable
class SubscribeToPrivateOrdersUseCase {
  final SubscribeToPrivateOrdersRepo subscribeToPrivateOrdersRepo;
  SubscribeToPrivateOrdersUseCase(this.subscribeToPrivateOrdersRepo);

  Stream<List<OrderEntity>>  subscribeToPrivateOrders(String freelancerId, ) => subscribeToPrivateOrdersRepo.subscribeToPrivateOrders(freelancerId);


}