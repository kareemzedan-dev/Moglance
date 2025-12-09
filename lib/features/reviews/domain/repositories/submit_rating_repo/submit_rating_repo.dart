import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';

abstract class SubmitRatingRepo {
  Future<Either<Failures, void>> submitRating({required ReviewsEntity reviews});
}