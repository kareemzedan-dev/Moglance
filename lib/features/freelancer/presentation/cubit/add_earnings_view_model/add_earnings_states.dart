class  AddEarningsStates {}
 class AddEarningsInitial extends AddEarningsStates {}
class AddEarningsLoadingState extends AddEarningsStates {}
class AddEarningsSuccessState extends AddEarningsStates {}
class AddEarningsErrorState extends AddEarningsStates {
  final String message;
  AddEarningsErrorState({required this.message});
}