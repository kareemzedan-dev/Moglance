import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/utils/network_utils.dart';

import '../../../../../../core/services/supabase_service.dart';
import '../../../../../../core/utils/strings_manager.dart';
import '../../../data_sources/remote/delete_order_data_source/delete_order_data_source.dart';
@Injectable(as:  DeleteOrderRemoteDataSource)
class DeleteOrderDataSourceImpl implements DeleteOrderRemoteDataSource {
  final SupabaseService supabaseService;
  DeleteOrderDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, void>> deleteOrder(String orderId) async {
    try {
      if (NetworkUtils.hasInternet() == false) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      await supabaseService.delete(
        table: "orders",
        id: orderId,
      );

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}