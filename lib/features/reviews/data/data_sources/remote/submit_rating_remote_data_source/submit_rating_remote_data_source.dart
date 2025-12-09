import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/reviews_entity/reviews_entity.dart';

abstract class SubmitRatingRemoteDataSource {
  Future<Either<Failures, void>> submitRating({required ReviewsEntity reviews});

}