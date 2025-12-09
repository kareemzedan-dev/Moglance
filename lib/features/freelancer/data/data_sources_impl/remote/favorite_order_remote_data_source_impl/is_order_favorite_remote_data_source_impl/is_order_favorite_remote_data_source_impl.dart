import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../data_sources/remote/favorite_order_remote_data_source/is_order_favorite_remote_data_source/is_order_favorite_remote_data_source.dart';
@Injectable(as: IsOrderFavoriteRemoteDataSource)
class IsOrderFavoriteRemoteDataSourceImpl
    implements IsOrderFavoriteRemoteDataSource {
  final SupabaseService supabaseService;
  IsOrderFavoriteRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, bool>> isOrderFavorite(
      String userId, String orderId) async {
    try {
      final response = await supabaseService.supabaseClient
          .from('favorite_order')
          .select('id') // مش محتاج كل الأعمدة
          .eq('user_id', userId)
          .eq('order_id', orderId)
          .limit(1); // يكفي أول نتيجة

      final isFav = (response as List).isNotEmpty;

      return Right(isFav);
    } catch (e) {
      return Left(ServerFailure(  e.toString()));
    }
  }
}
