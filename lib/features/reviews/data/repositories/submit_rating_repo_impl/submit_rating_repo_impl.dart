import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/reviews/domain/entities/reviews_entity/reviews_entity.dart';
import 'package:taskly/features/reviews/domain/repositories/submit_rating_repo/submit_rating_repo.dart';

import '../../data_sources/remote/submit_rating_remote_data_source/submit_rating_remote_data_source.dart';
@Injectable(as:  SubmitRatingRepo)
class SubmitRatingRepoImpl implements SubmitRatingRepo {
   final SubmitRatingRemoteDataSource remoteDataSource;
   SubmitRatingRepoImpl({required this.remoteDataSource});



  @override
  Future<Either<Failures, void>> submitRating({required ReviewsEntity reviews}) {
    return remoteDataSource.submitRating(reviews: reviews);
  }
}