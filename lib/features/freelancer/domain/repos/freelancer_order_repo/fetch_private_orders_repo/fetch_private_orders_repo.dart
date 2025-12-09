import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class FetchPrivateOrdersRepo {
   Future<Either<Failures, List<OrderEntity>>> fetchPrivateOrders(String freelancerId);
}