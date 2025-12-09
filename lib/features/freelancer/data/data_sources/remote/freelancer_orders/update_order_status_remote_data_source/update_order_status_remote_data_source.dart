import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';

abstract class UpdateOrderStatusRemoteDataSource {
  Future<Either<Failures, void>> updateOrderStatus(String orderId, String status);
}