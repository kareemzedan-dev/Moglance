import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/presentation/views/tabs/find_work/presentation/view_model/subscribe_to_public_orders_view_model/subscribe_to_public_orders_states.dart';

import '../../../../../../../../shared/domain/entities/order_entity/order_entity.dart';
import '../../../../../../../domain/use_cases/fetch_public_orders_use_case/fetch_public_orders_use_case.dart';
import '../../../../../../../domain/use_cases/subscribe_to_public_orders_use_case/subscribe_to_public_orders_use_case.dart';
@injectable
class SubscribeToPublicOrdersViewModel extends Cubit<SubscribeToPublicOrdersStates> {
  final SubscribeToPublicOrdersUseCase subscribeToPublicOrdersUseCase;
  final FetchPublicOrdersUseCase fetchPublicOrdersUseCase;
  StreamSubscription<List<OrderEntity>>? _ordersSubscription;

  final List<OrderEntity> _currentOrders = [];
  SubscribeToPublicOrdersViewModel(this.subscribeToPublicOrdersUseCase , this.fetchPublicOrdersUseCase) : super(SubscribeToPublicOrdersStatesInitial());


  void subscribeToPublicOrders(String freelancerId) async {
    _ordersSubscription?.cancel();

    final offersResponse = await fetchPublicOrdersUseCase.fetchPublicOrders(freelancerId);
    final offeredOrderIds = <String>[];
    offersResponse.fold(
          (_) {},
          (orders) => offeredOrderIds.addAll(orders.map((o) => o.id)),
    );
    _ordersSubscription = subscribeToPublicOrdersUseCase
        .subscribeToPublicOrders(freelancerId)
        .listen(
          (orders) {
        _currentOrders
          ..clear()
          ..addAll(
            orders.where((o) =>
            o.serviceType.name == 'public' &&
                !offeredOrderIds.contains(o.id)),
          );

        _currentOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        emit(SubscribeToPublicOrdersStatesSuccess(orders: List.from(_currentOrders)));

      },
      onError: (error) {
        emit(SubscribeToPublicOrdersStatesError(message: 'Real-time subscription error: $error'));

      },
    );

  }


  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}