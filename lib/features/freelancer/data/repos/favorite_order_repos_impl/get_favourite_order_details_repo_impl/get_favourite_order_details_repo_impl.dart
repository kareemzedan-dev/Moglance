

import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../domain/repos/favorite_order_repos/get_favourite_order_details_repo/get_favourite_order_details.dart';
import '../../../data_sources/remote/favorite_order_remote_data_source/get_favourite_order_details_remote_data_source/get_favourite_order_details_remote_data_source.dart';
@Injectable(as:  GetFavoriteOrderDetailsRepo)
class GetFavouriteOrderDetailsRepoImpl implements GetFavoriteOrderDetailsRepo {
  final GetFavouriteOrderDetailsRemoteDataSource getFavouriteOrderDetailsRemoteDataSource;
  GetFavouriteOrderDetailsRepoImpl(this.getFavouriteOrderDetailsRemoteDataSource);

  @override
  Future<Either<Failures, List<OrderEntity>>> getFavoriteOrdersDetails(List<String> orderIds) {
     return getFavouriteOrderDetailsRemoteDataSource.getFavoriteOrdersDetails(orderIds);
  }

}