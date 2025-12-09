import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/repos/favorite_order_repos/remove_favorite_order_repo/remove_favorite_order_repo.dart';
import '../../../data_sources/remote/favorite_order_remote_data_source/remove_favorite_order_remote_data_source/remove_favorite_order_remote_data_source.dart';
@Injectable(as:  RemoveFavoriteOrderRepo)
  class  RemoveFavoriteOrderRepoImpl implements RemoveFavoriteOrderRepo {
  final RemoveFavoriteOrderRemoteDataSource removeFavoriteOrderRemoteDataSource;
  RemoveFavoriteOrderRepoImpl(this.removeFavoriteOrderRemoteDataSource);



  @override
  Future<Either<Failures, void>> removeFavoriteOrder(String id) {
    return removeFavoriteOrderRemoteDataSource.removeFavoriteOrder(id);
  }
}