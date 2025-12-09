

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../../domain/entities/favorite_order_entity/favorite_order_entity.dart';
import '../../../../data_sources/remote/favorite_order_remote_data_source/get_favorite_order_remote_data_source/get_favorite_order_remote_data_source.dart';
@Injectable(as: GetFavoriteOrderRemoteDataSource)
class GetFavoriteOrderRemoteDataSourceImpl
    implements GetFavoriteOrderRemoteDataSource {
  final SupabaseService supabaseService;

  GetFavoriteOrderRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<FavoriteOrderEntity>>> getFavoritesByUser(
      String userId) async {
    try {
      final response = await supabaseService.supabaseClient
          .from('favorite_order')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      // هنا الـ response هو List<Map<String, dynamic>>
      final favorites = (response as List<dynamic>)
          .map((json) => FavoriteOrderEntity(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        orderId: json['order_id'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
      ))
          .toList();

      return Right(favorites);
    } catch (e) {
      return Left(ServerFailure(  e.toString()));
    }
  }
}
