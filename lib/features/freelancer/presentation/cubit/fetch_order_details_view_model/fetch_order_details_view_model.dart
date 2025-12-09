import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/freelancer/domain/use_cases/fetch_order_details_use_case/fetch_order_details_use_case.dart';
import 'package:taskly/features/freelancer/presentation/cubit/fetch_order_details_view_model/fetch_order_details_view_model_states.dart';

import '../../../../shared/domain/entities/order_entity/order_entity.dart';

@injectable
class FetchOrderDetailsViewModel
    extends Cubit<FetchOrderDetailsViewModelStates> {
  FetchOrderDetailsViewModel(this.fetchOrderDetailsUseCase)
      : super(FetchOrderDetailsViewModelStatesIntial());

  FetchOrderDetailsUseCase fetchOrderDetailsUseCase;

  Future<Either<Failures, OrderEntity>> fetchOrderDetails(
      String orderId) async {
    try {
      emit(FetchOrderDetailsViewModelStatesLoading());
      final result = await fetchOrderDetailsUseCase(orderId);
      result.fold((failure) =>
          emit(FetchOrderDetailsViewModelStatesError(
              message: failure.message)), (order) =>
          emit(FetchOrderDetailsViewModelStatesSuccess(orderEntity: order)));
      return result;
    }
    catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }



}