import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class DeleteOrderRepo {
  Future<Either<Failures, void>> deleteOrder(String orderId);
}