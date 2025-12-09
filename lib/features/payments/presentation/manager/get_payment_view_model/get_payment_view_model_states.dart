import 'package:taskly/features/payments/domain/entities/payment_entity.dart';

class GetPaymentViewModelStates {}

class GetPaymentViewModelInitial extends GetPaymentViewModelStates {}

class GetPaymentViewModelSuccess extends GetPaymentViewModelStates {
  final PaymentEntity payments;
  GetPaymentViewModelSuccess(this.payments);
}

class GetPaymentViewModelError extends GetPaymentViewModelStates {
  final String message;
  GetPaymentViewModelError(this.message);
}

class GetPaymentViewModelLoading extends GetPaymentViewModelStates {}