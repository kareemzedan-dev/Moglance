import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/freelancer/domain/entities/admin_settings_entity/admin_settings_entity.dart';
import 'package:taskly/features/freelancer/domain/repos/offer_repository/get_commission_repo/get_commission_repo.dart';

import '../../data_sources/remote/get_commission_remote_data_source/get_commission_remote_data_source.dart';
@Injectable(as:  GetCommissionRepo)
class GetCommissionRepoImpl implements GetCommissionRepo {
  final GetCommissionRemoteDataSource getCommissionRemoteDataSource;
  GetCommissionRepoImpl({required this.getCommissionRemoteDataSource});

  @override
  Future<Either<Failures, AdminSettingsEntity>> getCommission() {
 return getCommissionRemoteDataSource.getCommission();
  }


}