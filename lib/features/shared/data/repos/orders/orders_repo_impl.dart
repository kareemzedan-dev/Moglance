import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/shared/data/data_sources/remote/orders_remote_data_source.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/shared/domain/repos/orders/orders_repo.dart';
@Injectable(as: OrdersRepo)
class OrdersRepoImpl extends OrdersRepo{
  OrdersRemoteDataSource ordersRemoteDataSource;
  OrdersRepoImpl({required this.ordersRemoteDataSource});
  @override
  Future<Either<Failures, List<OrderEntity>>> getUserOrdersByUserId(String userId, String role) {
 return ordersRemoteDataSource.getUserOrdersByUserId(userId, role) ;
  }

  @override
  Stream<OrderEntity> subscribeToOrder(String orderId) {
     return ordersRemoteDataSource.subscribeToOrder(orderId);
  }

}