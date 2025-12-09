import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../shared/domain/entities/order_entity/order_entity.dart';

abstract class FetchPublicOrdersRepo {
   Future<Either<Failures, List<OrderEntity>>> fetchPublicOrders(String freelancerId);
}