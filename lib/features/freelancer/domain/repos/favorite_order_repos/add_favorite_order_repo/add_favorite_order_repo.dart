
import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/favorite_order_entity/favorite_order_entity.dart';

abstract class AddFavoriteOrderRepo {
  Future<Either<Failures, FavoriteOrderEntity>> addFavoriteOrder(FavoriteOrderEntity favoriteOrder);
}