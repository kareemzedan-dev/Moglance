import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../repos/favorite_order_repos/remove_favorite_order_repo/remove_favorite_order_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
  class RemoveFavoriteOrderUseCase {
    final RemoveFavoriteOrderRepo removeFavoriteOrderRepo;
    RemoveFavoriteOrderUseCase(this.removeFavoriteOrderRepo);
    Future<Either<Failures, void>>call(String id) {
      return removeFavoriteOrderRepo.removeFavoriteOrder(id);
    }

}