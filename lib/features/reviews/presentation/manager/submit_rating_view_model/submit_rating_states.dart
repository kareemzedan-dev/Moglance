

import '../../../../../core/errors/failures.dart';

abstract class SubmitRatingStates {}

class SubmitRatingStatesInitial extends SubmitRatingStates {}

class SubmitRatingStatesLoading extends SubmitRatingStates {}

class SubmitRatingStatesSuccess extends SubmitRatingStates {}

class SubmitRatingStatesError extends SubmitRatingStates {
  final Failures failure;

  SubmitRatingStatesError({required this.failure});
}