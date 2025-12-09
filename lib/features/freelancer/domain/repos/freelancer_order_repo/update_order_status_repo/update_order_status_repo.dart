import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class UpdateOrderStatusRepo {
  Future<Either<Failures, void>> updateOrderStatus(String orderId, String status);
}