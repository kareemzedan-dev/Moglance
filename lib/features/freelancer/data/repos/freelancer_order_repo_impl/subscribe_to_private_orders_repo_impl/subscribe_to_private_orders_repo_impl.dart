

import 'package:injectable/injectable.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../domain/repos/freelancer_order_repo/subscribe_to_private_orders_repo/subscribe_to_private_orders_repo.dart';
import '../../../data_sources/remote/freelancer_orders/subscribe_to_private_orders_remote_data_source/subscribe_to_private_orders_remote_data_source.dart';
@Injectable(as: SubscribeToPrivateOrdersRepo)
class SubscribeToPrivateOrdersRepoImpl implements SubscribeToPrivateOrdersRepo{
  final SubscribeToPrivateOrdersRemoteDataSource remoteDataSource;
  SubscribeToPrivateOrdersRepoImpl(this.remoteDataSource);

  @override
  Stream<List<OrderEntity>> subscribeToPrivateOrders(String freelancerId) {
   return remoteDataSource.subscribeToPrivateOrders(freelancerId);
  }
}