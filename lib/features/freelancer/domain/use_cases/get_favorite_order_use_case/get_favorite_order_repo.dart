

import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../entities/favorite_order_entity/favorite_order_entity.dart';
import '../../repos/favorite_order_repos/get_favorite_order_repo/get_favorite_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
  class GetFavoriteOrderUseCase {
    final GetFavoriteOrderRepo getFavoriteOrderRepo;
    GetFavoriteOrderUseCase(this.getFavoriteOrderRepo);
    Future<Either<Failures, List<FavoriteOrderEntity>>> call(String userId) {
      return getFavoriteOrderRepo.getFavoritesByUser(userId);
    }

}