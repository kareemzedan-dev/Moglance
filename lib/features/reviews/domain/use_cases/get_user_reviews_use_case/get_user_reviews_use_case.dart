import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/reviews_entity/reviews_entity.dart';
import '../../repositories/reviews_repo/reviews_repo.dart';
@injectable
class GetUserReviewsUseCase {
  final ReviewsRepo repo;

  GetUserReviewsUseCase(this.repo);

  Future<Either<Failures, List<ReviewsEntity>>> call({
    required String userId,
    required String role,
  }) async {
    return await repo.getUserReviews(userId: userId, role: role);
  }
}
