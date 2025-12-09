import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:taskly/features/freelancer/domain/use_cases/subscribe_to_private_orders_use_case/subscribe_to_private_orders_use_case.dart';
import 'freelancer_private_orders_view_model_states.dart';

@injectable
class FreelancerPrivateOrdersViewModel
    extends Cubit<FreelancerPrivateOrdersViewModelStates> {

  final SubscribeToPrivateOrdersUseCase subscribeToPrivateOrdersUseCase;
  StreamSubscription<List<OrderEntity>>? _ordersSubscription;
  String? _currentFreelancerId;
  List<String> offeredOrderIds = [];
  List<OrderEntity> _allOrders = [];
  List<OrderEntity> _filteredOrders = [];

  FreelancerPrivateOrdersViewModel(this.subscribeToPrivateOrdersUseCase)
      : super(FreelancerPrivateOrdersViewModelStatesInitial());

  Future<void> fetchAndSubscribePrivateOrders(String freelancerId) async {
    try {
      emit(FreelancerPrivateOrdersViewModelStatesLoading());
      _currentFreelancerId = freelancerId;

      _ordersSubscription?.cancel();

      _ordersSubscription = subscribeToPrivateOrdersUseCase
          .subscribeToPrivateOrders(freelancerId)
          .listen(
        _handleOrdersUpdate,
        onError: (error) {
          emit(FreelancerPrivateOrdersViewModelStatesError(
              message: 'Real-time subscription error: $error'));
        },
      );
    } catch (e) {
      final failure = Failures(e.toString());
      emit(FreelancerPrivateOrdersViewModelStatesError(message: failure.message));
    }
  }

  void _handleOrdersUpdate(List<OrderEntity> orders) {
    if (_currentFreelancerId == null) return;

    _allOrders = orders.where((order) =>
    order.serviceType.name.toLowerCase() == 'private' &&
        order.freelancerId == _currentFreelancerId).toList();

    _allOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _filteredOrders = List.from(_allOrders);

    emit(FreelancerPrivateOrdersViewModelStatesSuccess(
      orders: List.from(_filteredOrders),
      offeredOrderIds: offeredOrderIds,
    ));
  }

  int get privateOrdersCount => _filteredOrders.length;

  void searchOrders(String query) {
    if (query.isEmpty) {
      _filteredOrders = List.from(_allOrders);
    } else {
      _filteredOrders = _allOrders.where((order) {
        final title = order.title.toLowerCase();
        final serviceName = order.serviceType.name.toLowerCase();
        return title.contains(query.toLowerCase()) ||
            serviceName.contains(query.toLowerCase());
      }).toList();
    }

    emit(FreelancerPrivateOrdersViewModelStatesSuccess(
      orders: List.from(_filteredOrders),
      offeredOrderIds: offeredOrderIds,
    ));
  }

  Future<void> refreshOrders() async {
    if (_currentFreelancerId != null) {
      await fetchAndSubscribePrivateOrders(_currentFreelancerId!);
    }
  }

  void markOrderAsOffered(String orderId) {
    if (!offeredOrderIds.contains(orderId)) {
      offeredOrderIds.add(orderId);
      emit(FreelancerPrivateOrdersViewModelStatesSuccess(
        orders: List.from(_filteredOrders),
        offeredOrderIds: offeredOrderIds,
      ));
    }
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
