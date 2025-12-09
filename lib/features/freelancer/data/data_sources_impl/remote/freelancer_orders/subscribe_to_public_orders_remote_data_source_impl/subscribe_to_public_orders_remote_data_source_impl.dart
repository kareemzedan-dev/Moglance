import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../../../../core/utils/network_utils.dart';
import '../../../../../../shared/data/models/order_dm/order_dm.dart';
import '../../../../data_sources/remote/freelancer_orders/fetch_public_orders_remote_data_source/fetch_public_orders_remote_data_source.dart';
import '../../../../data_sources/remote/freelancer_orders/subscribe_to_public_orders_remote_data_source/subscribe_to_public_orders_remote_data_source.dart';

@Injectable(as: SubscribeToPublicOrdersRemoteDataSource)
class SubscribeToPublicOrdersRemoteDataSourceImpl
    implements SubscribeToPublicOrdersRemoteDataSource {
  final SupabaseService _supabaseService;
  final FetchPublicOrdersRemoteDataSource _fetchPublicOrdersRemoteDataSource;

  SubscribeToPublicOrdersRemoteDataSourceImpl(
      this._supabaseService, this._fetchPublicOrdersRemoteDataSource);

  @override
  Stream<List<OrderEntity>> subscribeToPublicOrders(String freelancerId) async* {
    final controller = StreamController<List<OrderEntity>>();
    final currentOrders = <OrderEntity>[];

    final channel = _supabaseService.supabaseClient.channel('public-orders-changes');

    void handleOrderChange(OrderEntity order) {
      if (order.serviceType.name != 'public' || order.status.name != 'Pending') return;

      final index = currentOrders.indexWhere((o) => o.id == order.id);
      if (index != -1) {
        currentOrders[index] = order;
      } else {
        currentOrders.insert(0, order);
      }

      currentOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      controller.add(List.from(currentOrders));
    }

    void handleDelete(String id) {
      currentOrders.removeWhere((o) => o.id == id);
      controller.add(List.from(currentOrders));
    }

    // 🧠 1️⃣ جهّز الاشتراك الأول
    channel
        .onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'orders',
      callback: (payload) {
        final order = OrderDm.fromJson(payload.newRecord).toEntity();
        handleOrderChange(order);
      },
    )
        .onPostgresChanges(
      event: PostgresChangeEvent.update,
      schema: 'public',
      table: 'orders',
      callback: (payload) {
        final order = OrderDm.fromJson(payload.newRecord).toEntity();
        handleOrderChange(order);
      },
    )
        .onPostgresChanges(
      event: PostgresChangeEvent.delete,
      schema: 'public',
      table: 'orders',
      callback: (payload) {
        final deletedId = payload.oldRecord['id'] as String;
        handleDelete(deletedId);
      },
    );

    // 🧠 2️⃣ استنى لحد ما الاشتراك يتم فعلاً
    await channel.subscribe((status, [error]) async {
      print('🔌 Public Orders channel status: $status');
      if (status == RealtimeSubscribeStatus.subscribed) {
        print('✅ Subscribed to public orders');

        // 🧠 3️⃣ بعد التأكد من الاشتراك، اعمل fetch أولي
        final result =
        await _fetchPublicOrdersRemoteDataSource.fetchPublicOrders(freelancerId);
        result.fold(
              (failure) => controller.addError(failure),
              (orders) {
            currentOrders
              ..clear()
              ..addAll(orders);
            controller.add(List.from(currentOrders));
            print('📦 Initial public orders loaded: ${orders.length}');
          },
        );
      }
    });

    controller.onCancel = () {
      print('❌ Unsubscribed from public orders');
      channel.unsubscribe();
    };

    yield* controller.stream;
  }
}
