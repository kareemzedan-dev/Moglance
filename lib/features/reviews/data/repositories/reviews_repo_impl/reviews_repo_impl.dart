import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';


import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/reviews_entity/reviews_entity.dart';
import '../../../domain/repositories/reviews_repo/reviews_repo.dart';
import '../../data_sources/remote/reviews_remote_data_source/reviews_remote_data_source.dart';
@Injectable(as: ReviewsRepo)  
class ReviewsRepoImpl implements ReviewsRepo{
  ReviewsRemoteDataSource remoteDataSource;
  ReviewsRepoImpl({required this.remoteDataSource});


  @override
  Future<Either<Failures, List<ReviewsEntity>>> getUserReviews({required String userId, required String role}) {
    return remoteDataSource.getUserReviews(userId: userId, role: role);
  }
}