
import '../../../domain/entities/reviews_entity/reviews_entity.dart';

class GetUserReviewsStates {}
class GetUserReviewsInitial extends GetUserReviewsStates {}

class GetUserReviewsLoading extends GetUserReviewsStates {}

class GetUserReviewsSuccess extends GetUserReviewsStates {
  final List<ReviewsEntity> reviewsList;
  GetUserReviewsSuccess(this.reviewsList);
}

class GetUserReviewsError extends GetUserReviewsStates {
  final String error;
  GetUserReviewsError(this.error);
}
