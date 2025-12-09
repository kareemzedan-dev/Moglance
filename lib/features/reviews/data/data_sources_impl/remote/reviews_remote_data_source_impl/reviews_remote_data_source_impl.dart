import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/reviews_entity/reviews_entity.dart';
import '../../../data_sources/remote/reviews_remote_data_source/reviews_remote_data_source.dart';
import '../../../models/reviews_model/reviews_model.dart';
@Injectable(as: ReviewsRemoteDataSource)
class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  final SupabaseClient supabase;

  ReviewsRemoteDataSourceImpl(this.supabase);

  @override
  Future<Either<Failures, List<ReviewsEntity>>> getUserReviews({
    required String userId,
    required String role,
  }) async {
    try {
      final response = await supabase
          .from('reviews')
          .select()
          .eq(role == 'client' ? 'client_id' : 'freelancer_id', userId);

      final data = response as List;
      return Right(
        data
            .map((json) => ReviewsModel.fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}
