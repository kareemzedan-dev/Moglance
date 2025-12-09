import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/repos/favorite_order_repos/is_order_favorite_repo/is_order_favorite_repo.dart';
import '../../../data_sources/remote/favorite_order_remote_data_source/is_order_favorite_remote_data_source/is_order_favorite_remote_data_source.dart';
@Injectable(as: IsOrderFavoriteRepo)
  class  IsOrderFavoriteRepoImpl implements IsOrderFavoriteRepo {
    final IsOrderFavoriteRemoteDataSource isOrderFavoriteRemoteDataSource;
     IsOrderFavoriteRepoImpl(this.isOrderFavoriteRemoteDataSource);

  @override
  Future<Either<Failures, bool>> isOrderFavorite(String userId, String orderId) {
 return isOrderFavoriteRemoteDataSource.isOrderFavorite(userId, orderId);
  }


}