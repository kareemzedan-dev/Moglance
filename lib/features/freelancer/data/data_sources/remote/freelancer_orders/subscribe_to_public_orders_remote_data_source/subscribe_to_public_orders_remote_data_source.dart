import '../../../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class SubscribeToPublicOrdersRemoteDataSource {
  Stream<List<OrderEntity>> subscribeToPublicOrders(String freelancerId);
}