
import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/reviews_entity/reviews_entity.dart';

abstract class ReviewsRepo {
 
  Future<Either<Failures, List<ReviewsEntity>>> getUserReviews({
    required String userId,
    required String role,  
  });
 

}
