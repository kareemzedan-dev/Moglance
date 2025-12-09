import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

abstract class OrdersRepo {
  Future<Either<Failures, List<OrderEntity>>> getUserOrdersByUserId(
    String userId,
    String role , 
  );
  Stream<OrderEntity> subscribeToOrder(String orderId);

}
