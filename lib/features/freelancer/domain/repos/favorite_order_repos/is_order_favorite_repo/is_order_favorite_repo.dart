import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class IsOrderFavoriteRepo {
  Future<Either<Failures, bool>> isOrderFavorite(String userId, String orderId);
}