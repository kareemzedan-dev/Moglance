import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/use_cases/my_jobs/subscribe_to_order_status_use_case/subscribe_to_order_status_use_case.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/shared/domain/use_cases/orders/orders_use_case.dart';
import 'package:taskly/features/client/presentation/views/tabs/my_jobs/presentation/view_model/get_order_view_model.dart/get_order_view_model_states.dart';

@injectable
class GetOrderViewModel extends Cubit<GetOrderViewModelStates> {
  GetOrderViewModel(this.ordersUseCase, this.myJobsUseCases)
      : super(GetOrderViewModelStatesInitial());

  final OrdersUseCase ordersUseCase;
  final SubscribeToOrderStatusUseCase myJobsUseCases;

  StreamSubscription<(OrderEntity, String)>? _ordersSubscription;
  List<OrderEntity> _orders = [];

  Future<Either<Failures, List<OrderEntity>>> getUserOrdersByUserId(
      String userId, String role) async {
    try {
      emit(GetOrderViewModelStatesLoading());
      var response = await ordersUseCase.callGetUserOrdersByUserId(userId, role);
      response.fold(
            (fnL) => emit(GetOrderViewModelStatesError(fnL.message)),
            (fnR) {
          _orders = fnR;
          emit(GetOrderViewModelStatesSuccess(List.from(fnR))); // استخدم List.from
        },
      );
      return response;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  void subscribeToOrderStatus({
    required Map<String, String> filters,
  }) {
    _ordersSubscription?.cancel();
    _ordersSubscription = myJobsUseCases.subscribeToOrderStatus(filters: filters).listen(
          (event) {
        final (order, action) = event;
        print('🔄 Order update: ${order.id} - $action - Status: ${order.status} - Client: ${order.clientId}');

        // تحقق إذا كان الطلب يخص المستخدم الحالي
        if (order.clientId != filters['client_id']) {
          print('⏭️ Skipping order ${order.id} - does not belong to current user');
          return; // تجاهل الطلبات التي لا تخص المستخدم الحالي
        }

        final updatedOrders = List<OrderEntity>.from(_orders);

        if (action == 'UPDATE' || action == 'UNKNOWN') {
          final index = updatedOrders.indexWhere((o) => o.id == order.id);
          if (index != -1) {
            updatedOrders[index] = order;
            print('✅ Updated order: ${order.id} with status: ${order.status}');
          } else {
            updatedOrders.add(order);
            print('➕ Added new order: ${order.id}');
          }
        } else if (action == 'DELETE') {
          updatedOrders.removeWhere((o) => o.id == order.id);
          print('🗑️ Deleted order: ${order.id}');
        } else if (action == 'INSERT') {
          updatedOrders.add(order);
          print('🆕 Inserted order: ${order.id}');
        }

        _orders = updatedOrders;

        emit(
          GetOrderViewModelStatesSuccess(
            _orders.map((o) => o.copyWith()).toList(),
          ),
        );

        print('🎯 Emitted new state with ${_orders.length} orders');
      },
      onError: (e) {
        print('❌ Subscription error: $e');
        emit(GetOrderViewModelStatesError(e.toString()));
      },
    );
  }

  Future<void> loadAndSubscribeOrders(String userId, String role) async {
    print('🚀 Loading and subscribing to orders for user: $userId');
    final response = await getUserOrdersByUserId(userId, role);
    response.fold(
          (l) => print('❌ Failed to load orders: ${l.message}'),
          (orders) {
        print('✅ Loaded ${orders.length} orders, starting subscription...');
        subscribeToOrderStatus(filters: {'client_id': userId});
      },
    );
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}