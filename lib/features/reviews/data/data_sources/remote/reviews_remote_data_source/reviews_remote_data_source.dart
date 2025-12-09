import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/reviews_entity/reviews_entity.dart';

abstract class ReviewsRemoteDataSource {
  /// get all reviews related to a specific user (client or freelancer)
  Future<Either<Failures, List<ReviewsEntity>>> getUserReviews({
    required String userId,
    required String role,
  });


}
