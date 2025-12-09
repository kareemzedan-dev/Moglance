import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/repos/home/home_repos.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

@injectable

class PlaceOrderUseCase {
  final HomeRepos homeRepos;
  PlaceOrderUseCase(this.homeRepos);
    Future<Either<Failures,OrderEntity>> callPlaceOrder(OrderEntity orderEntity) => homeRepos.placeOrder(orderEntity);
 

}