import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../domain/use_cases/my_jobs/delete_order_use_case/delete_order_use_case.dart';
import 'delete_order_states.dart';
@injectable
class DeleteOrderViewModel extends Cubit<DeleteOrderStates> {
  final DeleteOrderUseCase deleteOrderUseCase;

  DeleteOrderViewModel(this.deleteOrderUseCase) : super(DeleteOrderInitial());

  void deleteOrder(String orderId) async {
    emit(DeleteOrderLoadingState());

    final result = await deleteOrderUseCase(orderId);

    result.fold(
          (failure) {
        emit(DeleteOrderErrorState(failure.message));
      },
          (_) {
        emit(DeleteOrderSuccessState());
      },
    );
  }
}
