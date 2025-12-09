import 'package:taskly/features/payments/domain/entities/payment_entity.dart';

class GetWithdrawalHistoryStates {}

class GetWithdrawalHistoryInitial extends GetWithdrawalHistoryStates {}

class GetWithdrawalHistoryLoadingState extends GetWithdrawalHistoryStates {}

class GetWithdrawalHistorySuccessState extends GetWithdrawalHistoryStates {
  final List<PaymentEntity> withdrawalHistoryEntity;
  GetWithdrawalHistorySuccessState({required this.withdrawalHistoryEntity});
}

class GetWithdrawalHistoryErrorState extends GetWithdrawalHistoryStates {
  final String message;
  GetWithdrawalHistoryErrorState({required this.message});
}