


import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/features/freelancer/domain/entities/favorite_order_entity/favorite_order_entity.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/repos/favorite_order_repos/get_favorite_order_repo/get_favorite_order_repo.dart';
import '../../../data_sources/remote/favorite_order_remote_data_source/get_favorite_order_remote_data_source/get_favorite_order_remote_data_source.dart';
@Injectable(as: GetFavoriteOrderRepo)
  class GetFavoriteOrderRepoImpl implements  GetFavoriteOrderRepo {
    final GetFavoriteOrderRemoteDataSource getFavoriteOrderRemoteDataSource;
    GetFavoriteOrderRepoImpl(this.getFavoriteOrderRemoteDataSource);

  @override
  Future<Either<Failures, List<FavoriteOrderEntity>>> getFavoritesByUser(String userId) {
 return getFavoriteOrderRemoteDataSource.getFavoritesByUser(userId);
  }

}