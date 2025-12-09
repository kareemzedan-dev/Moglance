
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/reviews/domain/repositories/submit_rating_repo/submit_rating_repo.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/reviews_entity/reviews_entity.dart';
@injectable
class SubmitRatingUseCase {
  final SubmitRatingRepo submitRatingRepo ;
  SubmitRatingUseCase(this.submitRatingRepo);
  Future<Either<Failures,void>> call({required ReviewsEntity reviews}) async {
      return await submitRatingRepo.submitRating(reviews: reviews);
  }

}