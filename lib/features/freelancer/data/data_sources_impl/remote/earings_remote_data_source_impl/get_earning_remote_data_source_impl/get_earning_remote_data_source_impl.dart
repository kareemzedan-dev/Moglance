import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../../core/errors/failures.dart';
import '../../../../../../../core/services/supabase_service.dart';
import '../../../../../../../core/utils/network_utils.dart';
import '../../../../../domain/entities/earings_entity/earings_entity.dart';
import '../../../../data_sources/remote/earings_remote_data_source/get_earning_remote_data_source/get_earning_remote_data_source.dart';
@Injectable(as:  GetEarningRemoteDataSource)
class GetEarningRemoteDataSourceImpl implements GetEarningRemoteDataSource {
  final SupabaseService supabaseService;

  GetEarningRemoteDataSourceImpl({required this.supabaseService});

  @override
  Future<Either<Failures, EarningsEntity>> getEarnings({required String freelancerId}) async {
    try {
      if(!await NetworkUtils.hasInternet()){
        return Left(Failures('No internet connection'));
      }
      final freelancerData = await supabaseService.supabaseClient
          .from('freelancers')
          .select('freelancer_balance')
          .eq('id', freelancerId)
          .single();

      final userData = await supabaseService.supabaseClient
          .from('users')
          .select('total_earnings, completed_orders, total_orders')
          .eq('id', freelancerId)
          .single();

      final earnings = EarningsEntity(
        balance: (freelancerData['freelancer_balance'] ?? 0).toDouble(),
        completedOrders: (userData['completed_orders'] ?? 0) as int,
        totalOrders: (userData['total_orders'] ?? 0) as int,
        totalEarnings: (userData['total_earnings'] ?? 0).toDouble(),
      );

      return Right(earnings);
    } catch (e) {
      return Left(Failures(  e.toString()));
    }
  }
}
