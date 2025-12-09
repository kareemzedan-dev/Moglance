
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../../../../core/services/supabase_service.dart';
import '../../../../../../../core/utils/network_utils.dart';
import '../../../../../../shared/data/models/order_dm/order_dm.dart';
import '../../../../data_sources/remote/freelancer_orders/fetch_public_orders_remote_data_source/fetch_public_orders_remote_data_source.dart';
@Injectable(as: FetchPublicOrdersRemoteDataSource)
class FetchPublicOrdersRemoteDataSourceImpl implements FetchPublicOrdersRemoteDataSource {
  final SupabaseService _supabaseService;
  FetchPublicOrdersRemoteDataSourceImpl(this._supabaseService);

  @override
  Future<Either<Failures, List<OrderEntity>>> fetchPublicOrders(String freelancerId) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final response = await _supabaseService.supabaseClient
          .from('orders')
          .select('*')
          .eq('status', 'Pending')
          .eq('service_type', 'public');

      if ((response as List).isEmpty) return const Right([]);

      final orders = response
          .map((json) => OrderDm.fromJson(json).toEntity())
          .toList();

      return Right(orders);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch pending orders: $e'));
    }
  }
}
