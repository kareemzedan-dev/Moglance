import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/features/shared/data/data_sources/remote/orders_remote_data_source.dart';
import 'package:taskly/features/shared/data/models/order_dm/order_dm.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../../../core/utils/network_utils.dart';

@Injectable(as: OrdersRemoteDataSource)
class OrdersRemoteDataSourceImpl extends OrdersRemoteDataSource {
  final SupabaseService supabaseService  ;
  RealtimeChannel? _ordersChannel;

  OrdersRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<OrderEntity>>> getUserOrdersByUserId(
    String userId,
    String role,
  ) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure('No internet connection'));
      }


      String fieldName;
      if (role.toLowerCase() == 'client') {
        fieldName = "client_id";
      } else if (role.toLowerCase() == 'freelancer') {
        fieldName = "freelancer_id";
      } else {
        return const Left(Failures("Invalid role provided"));
      }

      _ordersChannel ??= supabaseService.subscribeWithCallbacks(
        table: 'orders',
        onData: (record, action) {
          final order = OrderDm.fromJson(record);
          print(
              'Realtime Change [$action]: Order ${order.id} - ${order.status}');
        },
      );

      final response = await supabaseService.getDataFromSupabase(
        tableName: "orders",
        filters: {fieldName: userId},
      );

      if (response == null || response.isEmpty) {
        return const Right([]);
      }

      final orders =
          response.map((e) => OrderDm.fromJson(e).toEntity()).toList();
      return Right(orders);
    } catch (e) {
      return Left(Failures(e.toString()));
    }
  }

  void unsubscribe() {
    if (_ordersChannel != null) {
      _ordersChannel?.unsubscribe();
      _ordersChannel = null;
    }
  }

  @override
  Stream<OrderEntity> subscribeToOrder(String orderId) {
    return supabaseService.supabaseClient
        .from('orders')
        .stream(primaryKey: ['id'])
        .eq('id', orderId)
        .map((records) => OrderDm.fromJson(records.first).toEntity());
  }

}
