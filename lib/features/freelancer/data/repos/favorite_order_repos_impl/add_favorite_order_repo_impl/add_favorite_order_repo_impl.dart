
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/domain/entities/favorite_order_entity/favorite_order_entity.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/repos/favorite_order_repos/add_favorite_order_repo/add_favorite_order_repo.dart';
import '../../../data_sources/remote/favorite_order_remote_data_source/add_favorite_order_remote_data_source/add_favorite_order_remote_data_source.dart';
@Injectable(as: AddFavoriteOrderRepo)
  class AddFavoriteOrderRepoImpl implements AddFavoriteOrderRepo {
  final AddFavoriteOrderRemoteDataSource addFavoriteOrderRemoteDataSource;
  AddFavoriteOrderRepoImpl(this.addFavoriteOrderRemoteDataSource);
  @override
  Future<Either<Failures, FavoriteOrderEntity>> addFavoriteOrder(FavoriteOrderEntity favoriteOrder) {
 return addFavoriteOrderRemoteDataSource.addFavoriteOrder(favoriteOrder);
  }
}