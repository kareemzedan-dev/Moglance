import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../repos/freelancer_order_repo/fetch_private_orders_repo/fetch_private_orders_repo.dart';
@injectable
class FetchPrivateOrdersUseCase {
  final FetchPrivateOrdersRepo fetchPrivateOrdersRepo;
  FetchPrivateOrdersUseCase(this.fetchPrivateOrdersRepo);
  Future<Either<Failures, List<OrderEntity>>> call(String freelancerId) => fetchPrivateOrdersRepo.fetchPrivateOrders(freelancerId);


}