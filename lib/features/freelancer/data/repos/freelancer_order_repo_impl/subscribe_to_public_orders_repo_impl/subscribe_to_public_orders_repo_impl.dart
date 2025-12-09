

import 'package:injectable/injectable.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../domain/repos/freelancer_order_repo/subscribe_to_public_orders_repo/subscribe_to_public_orders_repo.dart';
import '../../../data_sources/remote/freelancer_orders/subscribe_to_public_orders_remote_data_source/subscribe_to_public_orders_remote_data_source.dart';
@Injectable(as: SubscribeToPublicOrdersRepo)
class SubscribeToPublicOrdersRepoImpl implements SubscribeToPublicOrdersRepo {
  final SubscribeToPublicOrdersRemoteDataSource remoteDataSource;
  SubscribeToPublicOrdersRepoImpl(this.remoteDataSource);

  @override
  Stream<List<OrderEntity>> subscribeToPublicOrders(String freelancerId) {
  return remoteDataSource.subscribeToPublicOrders(freelancerId);
  }

}