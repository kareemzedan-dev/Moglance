import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/payments/domain/entities/payment_entity.dart';
import 'package:taskly/features/payments/domain/use_cases/get_payment/get_payment.dart';
import 'package:taskly/features/payments/presentation/manager/get_payment_view_model/get_payment_view_model_states.dart';
@injectable
class GetPaymentViewModel extends Cubit<GetPaymentViewModelStates> {
  GetPaymentViewModel(this.getPaymentUseCase)
    : super(GetPaymentViewModelInitial());
  GetPaymentUseCase getPaymentUseCase;
  Future< Either<Failures, PaymentEntity>> getPayment(String id) async {
    try {
      emit(GetPaymentViewModelLoading());
      final result = await getPaymentUseCase.call(id);
      result.fold(
        (l) => emit(GetPaymentViewModelError(l.message)),
        (r) => emit(GetPaymentViewModelSuccess(r)),

      );
      return result;
    } catch (e) {
      emit(GetPaymentViewModelError(e.toString()));
      return Left(Failures(e.toString()));
    }
  }
}
