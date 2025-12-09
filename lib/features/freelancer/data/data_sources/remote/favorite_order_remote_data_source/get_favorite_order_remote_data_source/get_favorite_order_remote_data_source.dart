

import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/favorite_order_entity/favorite_order_entity.dart';


abstract class GetFavoriteOrderRemoteDataSource {
  Future<Either<Failures, List<FavoriteOrderEntity>>>  getFavoritesByUser(String userId);
}