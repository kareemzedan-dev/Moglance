

import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/favorite_order_entity/favorite_order_entity.dart';

abstract class GetFavoriteOrderRepo {
  Future<Either<Failures, List<FavoriteOrderEntity>>>  getFavoritesByUser(String userId);
}