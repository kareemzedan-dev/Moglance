import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/shared/data/models/order_dm/order_dm.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../data_sources/remote/favorite_order_remote_data_source/get_favourite_order_details_remote_data_source/get_favourite_order_details_remote_data_source.dart';
@Injectable(as: GetFavouriteOrderDetailsRemoteDataSource)
class GetFavouriteOrderDetailsRemoteDataSourceImpl
    implements GetFavouriteOrderDetailsRemoteDataSource {
  final SupabaseService supabaseService;

  GetFavouriteOrderDetailsRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, List<OrderDm>>> getFavoriteOrdersDetails(
      List<String> orderIds) async {
    try {
      if (orderIds.isEmpty) {
        return const Right([]);
      }

      final response = await supabaseService.supabaseClient
          .from('orders')
          .select()
          .inFilter('id', orderIds);

      final orders = (response as List)
          .map((json) => OrderDm.fromJson(json))
          .toList();

      return Right(orders);
    } catch (e) {
      return Left(ServerFailure(  e.toString()));
    }
  }
}
