import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';
import 'package:taskly/features/reviews/presentation/manager/submit_rating_view_model/submit_rating_states.dart';

import '../../../domain/use_cases/submit_rating_use_case/submit_rating_use_case.dart';


@injectable
class SubmitRatingViewModel extends Cubit<SubmitRatingStates> {
  final SubmitRatingUseCase submitRatingUseCase;

  SubmitRatingViewModel(this.submitRatingUseCase)
      : super(SubmitRatingStatesInitial());

  Future<void> submitRating({
  required  ReviewsEntity reviews
  }) async {
    try {
      emit(SubmitRatingStatesLoading());

      final result = await submitRatingUseCase.call(
          reviews:  reviews
      );

      result.fold(
            (failure) => emit(SubmitRatingStatesError(failure: failure)),
            (success) => emit(SubmitRatingStatesSuccess()),
      );
    } catch (e) {
      emit(SubmitRatingStatesError(failure: ServerFailure(e.toString())));
    }
  }
}