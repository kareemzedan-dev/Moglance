
import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/favorite_order_entity/favorite_order_entity.dart';
import '../../repos/favorite_order_repos/add_favorite_order_repo/add_favorite_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
  class AddFavoriteOrderUseCase {
    final AddFavoriteOrderRepo addFavoriteOrderRepo;
    AddFavoriteOrderUseCase(this.addFavoriteOrderRepo);
    Future<Either<Failures, FavoriteOrderEntity>> call(FavoriteOrderEntity favoriteOrder) {
      return addFavoriteOrderRepo.addFavoriteOrder(favoriteOrder);
    }
}