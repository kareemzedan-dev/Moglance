import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import '../../../../../../../core/utils/network_utils.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../../../../core/services/supabase_service.dart';
import '../../../../../../shared/data/models/order_dm/order_dm.dart';
import '../../../../data_sources/remote/freelancer_orders/fetch_private_orders_remote_data_source/fetch_private_orders_remote_data_source.dart';

@Injectable(as: FetchPrivateOrdersRemoteDataSource)
class FetchPrivateOrdersRemoteDataSourceImpl
    implements FetchPrivateOrdersRemoteDataSource {
  final SupabaseService _supabaseService;

  FetchPrivateOrdersRemoteDataSourceImpl(this._supabaseService);
  @override
  Future<Either<Failures, List<OrderEntity>>> fetchPrivateOrders(
      String freelancerId) async {
    try {
         if (NetworkUtils.hasInternet() == false) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final response = await _supabaseService.supabaseClient
          .from('orders')
          .select('*')
          .eq('freelancer_id', freelancerId)
          .eq('service_type', 'private')
          .eq('status', 'Pending');

      // اطبع الريسبونس زي ما هو
      print("📦 Supabase raw response: $response");

      if ((response as List).isEmpty) {
        print("⚠️ No orders found for freelancerId: $freelancerId");
        return const Right([]);
      }

      final orders = response.map((json) {
        print("✅ Mapping order: $json"); // اطبع كل order json
        return OrderDm.fromJson(json);
      }).toList();

      print("🎯 Total mapped orders: ${orders.length}");
      return Right(orders);
    } catch (e, s) {
      print("❌ Error in fetchPrivateOrders: $e\n$s");
      return Left(ServerFailure('Failed to fetch private orders: $e'));
    }
  }
    }
