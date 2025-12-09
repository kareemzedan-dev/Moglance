import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/shared/domain/repos/orders/orders_repo.dart';
@injectable

class OrdersUseCase {
  OrdersRepo ordersRepo;

  OrdersUseCase(this.ordersRepo);
  Future<Either<Failures, List<OrderEntity>>> callGetUserOrdersByUserId(
    String userId,
    String role,
  ) => ordersRepo.getUserOrdersByUserId(userId, role);
  Stream<OrderEntity> callSubscribeToOrder(String orderId) => ordersRepo.subscribeToOrder(orderId);
}
