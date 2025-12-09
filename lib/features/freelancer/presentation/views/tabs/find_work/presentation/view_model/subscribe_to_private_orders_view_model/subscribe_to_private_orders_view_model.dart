import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/view_model/subscribe_to_private_orders_view_model/subscribe_to_private_orders_states.dart';
import '../../../../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../../../../../domain/use_cases/fetch_private_orders_use_case/fetch_private_orders_use_case.dart';
import '../../../../../../../domain/use_cases/subscribe_to_private_orders_use_case/subscribe_to_private_orders_use_case.dart';

@injectable
class SubscribeToPrivateOrdersViewModel extends Cubit<SubscribeToPrivateOrdersStates> {
  final SubscribeToPrivateOrdersUseCase subscribeToPrivateOrdersUseCase;
  final FetchPrivateOrdersUseCase fetchPrivateOrdersUseCase;

  SubscribeToPrivateOrdersViewModel(
      this.subscribeToPrivateOrdersUseCase,
      this.fetchPrivateOrdersUseCase
      ) : super(SubscribeToPrivateOrdersStatesInitial());

  StreamSubscription<List<OrderEntity>>? _ordersSubscription;

Stream<List<OrderEntity>> subscribeToPrivateOrdersStream(String freelancerId) {
  return subscribeToPrivateOrdersUseCase
      .subscribeToPrivateOrders(freelancerId)
      .map((orders) => orders
          .where((o) =>
              o.serviceType.name.toLowerCase() == 'private' &&
              o.freelancerId == freelancerId)
          .toList());
}


  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
