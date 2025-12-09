import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';

import '../../../../../../../core/services/supabase_service.dart';
import '../../../../data_sources/remote/freelancer_orders/update_order_status_remote_data_source/update_order_status_remote_data_source.dart';
@Injectable(as: UpdateOrderStatusRemoteDataSource)
class UpdateOrderStatusRemoteDataSourceImpl implements UpdateOrderStatusRemoteDataSource {
  final SupabaseService _supabaseService;
  UpdateOrderStatusRemoteDataSourceImpl(this._supabaseService);


  @override
  Future<Either<Failures, void>> updateOrderStatus(
      String orderId, String status) async {
    try {
      await _supabaseService.supabaseClient
          .from('orders')
          .update({'status': status})
          .eq('id', orderId);
      return const Right(null);
    } catch (e, st) { // st = stack trace
      print("❌ Failed to update order status: $e");
      print(st);
      return Left(ServerFailure('Failed to update order status: $e'));
    }
  }


}