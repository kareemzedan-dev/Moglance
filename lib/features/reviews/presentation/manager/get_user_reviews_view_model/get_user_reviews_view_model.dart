import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/reviews_entity/reviews_entity.dart';
import '../../../domain/use_cases/get_user_reviews_use_case/get_user_reviews_use_case.dart';
import 'get_user_reviews_states.dart';

@injectable
class GetUserReviewsViewModel extends Cubit<GetUserReviewsStates> {
  final GetUserReviewsUseCase getUserReviewsUseCase;

  GetUserReviewsViewModel(this.getUserReviewsUseCase)
      : super(GetUserReviewsInitial());

  Future<void> getUserReviews(String userId, String role) async {
    try {
      emit(GetUserReviewsLoading());

      final result = await getUserReviewsUseCase.call(
        userId: userId,
        role: role,
      );

      result.fold(
        (failure) => emit(GetUserReviewsError( "" )),
        (reviews) => emit(GetUserReviewsSuccess(reviews)),
      );
    } catch (e) {
      emit(GetUserReviewsError(e.toString()));
    }
  }

  /// حساب توزيع النجوم
  Map<int, int> calculateRatings(List<ReviewsEntity> reviews) {
    final Map<int, int> distribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};

    for (var review in reviews) {
      final rating = double.tryParse(review.rating) ?? 0.0;
      final rounded = rating.round().clamp(1, 5);
      distribution[rounded] = (distribution[rounded] ?? 0) + 1;
    }

    return distribution;
  }

  /// إجمالي الريفيوهات
  int getTotal(List<ReviewsEntity> reviews) => reviews.length;

  /// المتوسط
  double calculateAverage(List<ReviewsEntity> reviews) {
    if (reviews.isEmpty) return 0.0;

    final sum = reviews
        .map((e) => double.tryParse(e.rating) ?? 0)
        .reduce((a, b) => a + b);

    return sum / reviews.length;
  }
}
