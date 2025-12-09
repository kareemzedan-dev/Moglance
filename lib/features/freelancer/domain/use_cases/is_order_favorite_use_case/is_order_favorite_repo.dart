import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../repos/favorite_order_repos/is_order_favorite_repo/is_order_favorite_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
  class IsOrderFavoriteUseCase {
    final IsOrderFavoriteRepo isOrderFavoriteRepo;
    IsOrderFavoriteUseCase(this.isOrderFavoriteRepo);
    Future<Either<Failures, bool>> call(String userId, String orderId) {
      return isOrderFavoriteRepo.isOrderFavorite(userId, orderId);
    }
}