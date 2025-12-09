import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/payment_entity.dart';
import '../../../domain/use_cases/create_payment_use_case/create_payment_use_case.dart';
import 'create_payment_view_model_states.dart';
@injectable
class CreatePaymentViewModel extends Cubit<CreatePaymentViewModelStates> {
  CreatePaymentViewModel(this.createPaymentUseCase)
    : super(CreatePaymentViewModelStatesInitial());
  CreatePaymentUseCase createPaymentUseCase;

  Future<Either<Failures, PaymentEntity>> createPayment(
    PaymentEntity paymentEntity,
  ) async {
    try {
      emit(CreatePaymentViewModelStatesLoading());
      final result = await createPaymentUseCase(paymentEntity);
      result.fold(
        (failure) => emit(CreatePaymentViewModelStatesError( failure.message)),
        (paymentEntity) =>
            emit(CreatePaymentViewModelStatesSuccess(paymentEntity)),

      );
      return result;
    } catch (e) {
   return   Left(Failures(e.toString()));
    }
  }
}
