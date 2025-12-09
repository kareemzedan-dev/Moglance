
import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/utils/network_utils.dart';

import 'package:taskly/features/freelancer/domain/entities/admin_settings_entity/admin_settings_entity.dart';

import '../../../../../../core/services/supabase_service.dart';
import '../../../data_sources/remote/get_commission_remote_data_source/get_commission_remote_data_source.dart';
import '../../../models/admin_settings_model/admin_settings_model.dart';
@Injectable(as: GetCommissionRemoteDataSource)
class GetCommissionRemoteDataSourceImpl implements GetCommissionRemoteDataSource {
  final SupabaseService supabaseService;

  GetCommissionRemoteDataSourceImpl({required this.supabaseService});

  @override
  Future<Either<Failures, AdminSettingsEntity>> getCommission() async {
    try {
      // فحص الاتصال بالإنترنت
      final hasInternet = await NetworkUtils.hasInternet();
      if (!hasInternet) {
        return const Left(NetworkFailure('No internet connection'));
      }

      // جلب البيانات من جدول admin_settings
      final response = await supabaseService.supabaseClient
          .from('admin_settings')
          .select()
          .single();

      // تحويل response إلى Entity
      final adminSettings = AdminSettingsModel.fromJson(response);
      return Right(adminSettings);

    } catch (e, st) {
      print('Error fetching commission: $e\n$st');
      return Left(ServerFailure(e.toString()));
    }
  }
}
