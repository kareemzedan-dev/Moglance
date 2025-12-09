import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/utils/strings_manager.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import '../../../../../../../domain/use_cases/fetch_public_orders_use_case/fetch_public_orders_use_case.dart';
import '../../../../../../../domain/use_cases/subscribe_to_public_orders_use_case/subscribe_to_public_orders_use_case.dart';
import 'freelancer_public_order_states.dart';

@injectable
class FreelancerPublicOrdersViewModel extends Cubit<FreelancerPublicOrdersState> {
  final FetchPublicOrdersUseCase freelancerOrderUseCase;
  final SubscribeToPublicOrdersUseCase subscribeToPublicOrdersUseCase;

  StreamSubscription<List<OrderEntity>>? _ordersSubscription;

  final List<OrderEntity> _allOrders = [];
  List<OrderEntity> _filteredOrders = [];
  final List<String> _offeredOrderIds = [];

  FreelancerPublicOrdersViewModel(
      this.freelancerOrderUseCase,
      this.subscribeToPublicOrdersUseCase,
      ) : super(FreelancerPendingOrdersInitial());

  Future<void> fetchAndSubscribePendingOrders() async {
    emit(FreelancerPendingOrdersLoading());

    try {
      final freelancerId = SharedPrefHelper.getString(StringsManager.idKey)!;

      // ✅ نجيب العروض بتاعت الفريلانسر
      final offersResponse = await Supabase.instance.client
          .from('offers')
          .select('order_id, status')
          .eq('freelancer_id', freelancerId)
          .neq('status', 'withdrawn')
          .neq("status", 'Rejected');

      _offeredOrderIds
        ..clear()
        ..addAll((offersResponse as List).map((e) => e['order_id'] as String));

      // ✅ هنا نستخدم fold صح
      final result = await freelancerOrderUseCase.fetchPublicOrders(freelancerId);

      result.fold(
            (failure) {

          emit(FreelancerPendingOrdersError(
            failure.message ?? 'Failed to load orders. Please check your internet connection.',
          ));
        },
            (orders) {
          // ✅ حالة النجاح
          _allOrders
            ..clear()
            ..addAll(orders);

          _allOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          _filteredOrders = List.from(_allOrders);

          emit(FreelancerPendingOrdersSuccess(List.from(_filteredOrders)));


          _subscribeToRealtime(freelancerId);
        },
      );
    } catch (e) {
      // ⚠️ أي Error غير متوقع
      emit(FreelancerPendingOrdersError('Unexpected error occurred: $e'));
    }
  }

  void _subscribeToRealtime(String freelancerId) {
    _ordersSubscription = subscribeToPublicOrdersUseCase
        .subscribeToPublicOrders(freelancerId)
        .listen((orders) {
      _allOrders
        ..clear()
        ..addAll(orders);

      _allOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _filteredOrders = List.from(_allOrders);

      emit(FreelancerPendingOrdersSuccess(List.from(_filteredOrders)));
    });
  }

  int get publicOrdersCount => _filteredOrders.length;
  List<String> get offeredOrderIds => _offeredOrderIds;

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

    emit(FreelancerPendingOrdersSuccess(List.from(_filteredOrders)));
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
