
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../../domain/entities/favorite_order_entity/favorite_order_entity.dart';
import '../../../../data_sources/remote/favorite_order_remote_data_source/add_favorite_order_remote_data_source/add_favorite_order_remote_data_source.dart';

@Injectable(as: AddFavoriteOrderRemoteDataSource)
class AddFavoriteOrderRemoteDataSourceImpl
    implements AddFavoriteOrderRemoteDataSource {
  final SupabaseService supabaseService;

  AddFavoriteOrderRemoteDataSourceImpl(this.supabaseService);
  @override
  Future<Either<Failures, FavoriteOrderEntity>> addFavoriteOrder(FavoriteOrderEntity favoriteOrder) async {
    try {
      // أولًا جلب كل الـ favorite orders للمستخدم
      final existingOrdersResponse = await supabaseService.supabaseClient
          .from('favorite_order')
          .select('order_id')
          .eq('user_id', favoriteOrder.userId);

      final existingOrders = (existingOrdersResponse as List)
          .map((e) => e['order_id'] as String)
          .toList();

      // لو الـ order موجود بالفعل، نرجع فشل
      if (existingOrders.contains(favoriteOrder.orderId)) {
        return const Left(ServerFailure('Order already added to favorites'));
      }

      // لو مش موجود، نضيفه
      final response = await supabaseService.supabaseClient
          .from('favorite_order')
          .insert({
        'user_id': favoriteOrder.userId,
        'order_id': favoriteOrder.orderId,
        'created_at': favoriteOrder.createdAt.toIso8601String(),
      })
          .select()
          .single();

      final savedFavorite = FavoriteOrderEntity(
        id: response['id'] as String,
        userId: response['user_id'] as String,
        orderId: response['order_id'] as String,
        createdAt: DateTime.parse(response['created_at'] as String),
      );

      return Right(savedFavorite);

    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }



}
