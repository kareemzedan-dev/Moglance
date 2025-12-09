import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import '../../../../../../../core/utils/network_utils.dart';
import '../../../../data_sources/remote/earings_remote_data_source/add_earning_remote_data_source/add_earning_remote_data_source.dart';

@Injectable(as: AddEarningRemoteDataSource)
class AddEarningRemoteDataSourceImpl implements AddEarningRemoteDataSource {
  final SupabaseService supabaseService;

  AddEarningRemoteDataSourceImpl({required this.supabaseService});

  @override
  Future<Either<Failures, void>> addEarning({
    required String freelancerId,
    required String clientId,
    required double amount,
  }) async {
    try {
      // ✅ تحقق من الاتصال بالإنترنت
      if (!await NetworkUtils.hasInternet()) {
        return Left(Failures('No internet connection'));
      }

      final commissionData = await supabaseService.supabaseClient
          .from('admin_settings')
          .select('commission')
          .maybeSingle();

      if (commissionData == null || commissionData['commission'] == null) {
        return Left(Failures('Commission percentage not found'));
      }

      final commissionPercentage =
      (commissionData['commission'] as num).toDouble();

      final commissionAmount = amount * (commissionPercentage / 100);
      final netAmount = amount - commissionAmount;

      print(
          "💰 Total: $amount | Commission: $commissionAmount | Net: $netAmount");

      final freelancerData = await supabaseService.supabaseClient
          .from('freelancers')
          .select('freelancer_balance')
          .eq('id', freelancerId)
          .maybeSingle();

      if (freelancerData == null) {
        return Left(Failures('Freelancer not found'));
      }

      final currentBalance =
      (freelancerData['freelancer_balance'] ?? 0).toDouble();

      await supabaseService.supabaseClient
          .from('freelancers')
          .update({'freelancer_balance': currentBalance + netAmount})
          .eq('id', freelancerId);

      final freelancerUserData = await supabaseService.supabaseClient
          .from('users')
          .select('total_orders, completed_orders, total_earnings')
          .eq('id', freelancerId)
          .maybeSingle();

      final clientUserData = await supabaseService.supabaseClient
          .from('users')
          .select('total_orders, completed_orders, total_earnings')
          .eq('id', clientId)
          .maybeSingle();

      if (freelancerUserData == null || clientUserData == null) {
        return Left(Failures('User data not found'));
      }

      final freelancerTotalOrders =
      (freelancerUserData['total_orders'] ?? 0) as int;
      final freelancerCompletedOrders =
      (freelancerUserData['completed_orders'] ?? 0) as int;
      final freelancerTotalEarnings =
      (freelancerUserData['total_earnings'] ?? 0).toDouble();

      final clientTotalOrders = (clientUserData['total_orders'] ?? 0) as int;
      final clientCompletedOrders =
      (clientUserData['completed_orders'] ?? 0) as int;
      final clientTotalEarnings =
      (clientUserData['total_earnings'] ?? 0).toDouble();

      await supabaseService.supabaseClient.from('users').update({
        'total_orders': freelancerTotalOrders + 1,
        'completed_orders': freelancerCompletedOrders + 1,
        'total_earnings': freelancerTotalEarnings + netAmount,
      }).eq('id', freelancerId);

      await supabaseService.supabaseClient.from('users').update({
        'total_orders': clientTotalOrders + 1,
        'completed_orders': clientCompletedOrders + 1,
        'total_earnings': clientTotalEarnings + amount,
      }).eq('id', clientId);

      print("✅ Freelancer & Client stats updated successfully after payment.");
      return const Right(null);
    } catch (e) {
      print("❌ Error in addEarning: $e");
      return Left(Failures(e.toString()));
    }
  }
}
