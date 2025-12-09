import '../../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class SubscribeToPublicOrdersRepo {
  Stream<List<OrderEntity>>  subscribeToPublicOrders(String freelancerId);
}