import '../../../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class SubscribeToPrivateOrdersRemoteDataSource {
  Stream<List<OrderEntity>> subscribeToPrivateOrders(String freelancerId);
}