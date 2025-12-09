
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../domain/repos/freelancer_order_repo/fetch_public_orders_repo/fetch_public_orders_repo.dart';
import '../../../data_sources/remote/freelancer_orders/fetch_public_orders_remote_data_source/fetch_public_orders_remote_data_source.dart';
@Injectable(as: FetchPublicOrdersRepo)
class FetchPublicOrdersRepoImpl implements FetchPublicOrdersRepo{
  final FetchPublicOrdersRemoteDataSource remoteDataSource;
  FetchPublicOrdersRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, List<OrderEntity>>> fetchPublicOrders(String freelancerId) {
 return remoteDataSource.fetchPublicOrders(freelancerId);
  }

}