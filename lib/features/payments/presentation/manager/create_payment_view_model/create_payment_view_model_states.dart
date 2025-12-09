import '../../../domain/entities/payment_entity.dart';

class CreatePaymentViewModelStates {}
class CreatePaymentViewModelStatesInitial extends CreatePaymentViewModelStates {}
class CreatePaymentViewModelStatesSuccess extends CreatePaymentViewModelStates {
  PaymentEntity paymentEntity;
  CreatePaymentViewModelStatesSuccess(this.paymentEntity);
}
class CreatePaymentViewModelStatesLoading extends CreatePaymentViewModelStates {}
class CreatePaymentViewModelStatesError extends CreatePaymentViewModelStates {
  String message;
  CreatePaymentViewModelStatesError(this.message);
}