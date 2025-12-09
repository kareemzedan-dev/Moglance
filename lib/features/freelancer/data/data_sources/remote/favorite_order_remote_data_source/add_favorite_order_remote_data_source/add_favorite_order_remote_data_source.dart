
import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/favorite_order_entity/favorite_order_entity.dart';


abstract class AddFavoriteOrderRemoteDataSource {
  Future<Either<Failures, FavoriteOrderEntity>> addFavoriteOrder(FavoriteOrderEntity favoriteOrder);
}