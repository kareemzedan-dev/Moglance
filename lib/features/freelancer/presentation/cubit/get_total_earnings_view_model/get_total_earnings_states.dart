import '../../../domain/entities/earings_entity/earings_entity.dart';

class GetTotalEarningsStates {}
class GetTotalEarningsInitial extends GetTotalEarningsStates {}
class GetTotalEarningsLoadingState extends GetTotalEarningsStates {}
class GetTotalEarningsSuccessState extends GetTotalEarningsStates {
  final EarningsEntity earningsEntity;
  GetTotalEarningsSuccessState({required this.earningsEntity});
}
class GetTotalEarningsErrorState extends GetTotalEarningsStates {
  final String message;
  GetTotalEarningsErrorState({required this.message});
}