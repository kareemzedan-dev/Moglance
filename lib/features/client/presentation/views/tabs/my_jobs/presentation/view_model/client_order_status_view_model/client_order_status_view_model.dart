import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import '../../../../../../../domain/use_cases/my_jobs/subscribe_to_orders_use_case/subscribe_to_orders_use_case.dart';
import 'client_order_status_states.dart';

@injectable
class ClientOrderStatusViewModel extends Cubit<OrderStatusState> {
  final SubscribetToOrdersUseCase clientOrderUseCase;
  StreamSubscription<(OrderEntity, String)>? _orderSubscription;

  ClientOrderStatusViewModel(this.clientOrderUseCase)
      : super(OrderStatusInitial());

  void subscribeToOrder(String orderId) {
    _orderSubscription = clientOrderUseCase.subscribeToOrders({'id': orderId}).listen(
      (event) {
        final (order, action) = event;
        emit(OrderStatusUpdated(order));
      },
    );
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}

