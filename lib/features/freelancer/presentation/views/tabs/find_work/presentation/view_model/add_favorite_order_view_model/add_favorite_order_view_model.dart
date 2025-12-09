import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/domain/use_cases/add_favorite_order_use_case/add_favorite_order_repo.dart';

import '../../../../../../../domain/entities/favorite_order_entity/favorite_order_entity.dart';
import 'add_favorite_order_states.dart';

@injectable
class AddFavoriteOrderViewModel extends Cubit<AddFavoriteOrderStates> {
  AddFavoriteOrderUseCase addFavoriteOrderUseCase;

  // Map لتخزين كل الـ FavoriteOrderEntities حسب orderId
  final Map<String, FavoriteOrderEntity> _favoriteOrders = {};

  AddFavoriteOrderViewModel(this.addFavoriteOrderUseCase)
      : super(AddFavoriteOrderInitial());

  // ✅ Getter للوصول للـ favorite IDs
  List<String> get favoriteOrderIds => _favoriteOrders.keys.toList();

  bool isFavorite(String orderId) => _favoriteOrders.containsKey(orderId);

  FavoriteOrderEntity? getFavoriteEntityByOrderId(String orderId) {
    return _favoriteOrders[orderId];
  }

  Future<void> toggleFavorite(FavoriteOrderEntity favoriteOrder) async {
    final orderId = favoriteOrder.orderId;
    if (_favoriteOrders.containsKey(orderId)) {
      // إزالة
      _favoriteOrders.remove(orderId);
      emit(AddFavoriteOrderRemovedState(orderId));
    } else {
      emit(AddFavoriteOrderLoadingState());

      final result = await addFavoriteOrderUseCase(favoriteOrder);

      result.fold(
            (failure) => emit(AddFavoriteOrderErrorState(failure.message)),
            (savedFavorite) {
          // هنا احفظ الـ ID الحقيقي اللي رجع من Supabase
          _favoriteOrders[orderId] = savedFavorite;
          emit(AddFavoriteOrderSuccessState("Added successfully", orderId));
        },
      );
    }
  }


  void loadFavorites(List<FavoriteOrderEntity> favoriteOrders) {
    _favoriteOrders.clear();
    for (var fav in favoriteOrders) {
      _favoriteOrders[fav.orderId] = fav;
    }
    emit(AddFavoriteOrderLoadedState(_favoriteOrders.keys.toList()));
  }

  void removeFavorite(String orderId) {
    _favoriteOrders.remove(orderId);
    emit(AddFavoriteOrderRemovedState(orderId));
  }
}
