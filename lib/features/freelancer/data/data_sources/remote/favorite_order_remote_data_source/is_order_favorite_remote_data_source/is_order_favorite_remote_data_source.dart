import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';

abstract class  IsOrderFavoriteRemoteDataSource {
  Future<Either<Failures, bool>> isOrderFavorite(String userId, String orderId);
}