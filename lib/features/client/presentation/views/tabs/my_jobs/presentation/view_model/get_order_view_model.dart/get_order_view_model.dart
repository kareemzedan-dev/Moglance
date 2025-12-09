import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/use_cases/my_jobs/subscribe_to_order_status_use_case/subscribe_to_order_status_use_case.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/shared/domain/use_cases/orders/orders_use_case.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_order_view_model.dart/get_order_view_model_states.dart';

import '../../../../../../../../../core/di/di.dart';
import '../offers_notification_cubit/offers_notification_cubit.dart';

@injectable
class GetOrderViewModel extends Cubit<GetOrderViewModelStates> {
  // ------------------ Inject dependencies ------------------
  final OrdersUseCase ordersUseCase;
  final SubscribeToOrderStatusUseCase myJobsUseCases;

  GetOrderViewModel(
      this.ordersUseCase,
      this.myJobsUseCases,
      ) : super(GetOrderViewModelStatesInitial());


  // ------------------ Variables ------------------
  StreamSubscription<(OrderEntity, String)>? _ordersSubscription;
  List<OrderEntity> _orders = [];

  // ------------------ Load Orders ------------------
  Future<Either<Failures, List<OrderEntity>>> getUserOrdersByUserId(
      String userId, String role) async {
    try {
      emit(GetOrderViewModelStatesLoading());
      var response = await ordersUseCase.callGetUserOrdersByUserId(userId, role);

      response.fold(
            (failure) => emit(GetOrderViewModelStatesError(failure.message)),
            (ordersList) {
          _orders = ordersList;
          emit(GetOrderViewModelStatesSuccess(List.from(ordersList)));
        },
      );

      return response;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ------------------ Subscribe to Order Status ------------------
  void subscribeToOrderStatus({
    required Map<String, String> filters,
  }) {
    _ordersSubscription?.cancel();
    _ordersSubscription =
        myJobsUseCases.subscribeToOrderStatus(filters: filters).listen(
              (event) {
            final (order, action) = event;

            print(
                '🔄 Order update: ${order.id} - $action - Status: ${order.status}');

            if (order.clientId != filters['client_id']) {
              print('⏭️ Skipping order not for this user');
              return;
            }

            final updated = List<OrderEntity>.from(_orders);

            if (action == 'UPDATE' || action == 'UNKNOWN') {
              final idx = updated.indexWhere((o) => o.id == order.id);
              if (idx != -1)
                updated[idx] = order;
              else
                updated.add(order);
            } else if (action == 'DELETE') {
              updated.removeWhere((o) => o.id == order.id);
            } else if (action == 'INSERT') {
              updated.add(order);
            }

            _orders = updated;

            emit(GetOrderViewModelStatesSuccess(
              _orders.map((o) => o.copyWith()).toList(),
            ));
          },
          onError: (e) {
            emit(GetOrderViewModelStatesError(e.toString()));
          },
        );
  }

  // ------------------ Subscribe to Offers (Global Badge) ------------------
  RealtimeChannel subscribeToOffers({required String orderId}) {
    final channel = Supabase.instance.client
        .channel('offers_global_$orderId')
        .onPostgresChanges(
      event: PostgresChangeEvent.insert,
      schema: 'public',
      table: 'offers',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'order_id',
        value: orderId,
      ),
      callback: (payload) {
        print("🔥 OFFER INSERT for order → $orderId");

        // 🔥 هنا يتم تشغيل البادج
        getIt<OffersNotificationCubit>().newOfferArrived();

      },
    ).subscribe();

    return channel;
  }

  // ------------------ Load + Subscribe ------------------
  Future<void> loadAndSubscribeOrders(String userId, String role) async {
    final response = await getUserOrdersByUserId(userId, role);

    response.fold(
          (l) => print('❌ Error loading orders'),
          (orders) {
        subscribeToOrderStatus(filters: {'client_id': userId});
      },
    );
  }

  // ------------------ Load Once ------------------
  Future<List<OrderEntity>> loadOrdersOnce(String userId, String role) async {
    final result = await ordersUseCase.callGetUserOrdersByUserId(userId, role);
    return result.fold((l) => [], (r) => r);
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
