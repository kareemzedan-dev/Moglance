

import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../domain/repos/freelancer_order_repo/fetch_private_orders_repo/fetch_private_orders_repo.dart';
import '../../../data_sources/remote/freelancer_orders/fetch_private_orders_remote_data_source/fetch_private_orders_remote_data_source.dart';
@Injectable(as: FetchPrivateOrdersRepo)
class FetchPrivateOrdersRepoImpl implements FetchPrivateOrdersRepo{
  final FetchPrivateOrdersRemoteDataSource remoteDataSource;
  FetchPrivateOrdersRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, List<OrderEntity>>> fetchPrivateOrders(String freelancerId) {
  return remoteDataSource.fetchPrivateOrders(freelancerId);
  }


}