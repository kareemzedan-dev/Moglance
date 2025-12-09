import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/admin_settings_entity/admin_settings_entity.dart';

abstract class GetCommissionRemoteDataSource {
  Future<Either<Failures, AdminSettingsEntity>> getCommission();
}