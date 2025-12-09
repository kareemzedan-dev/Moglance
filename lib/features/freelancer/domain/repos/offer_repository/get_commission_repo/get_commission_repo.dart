import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/admin_settings_entity/admin_settings_entity.dart';

abstract class GetCommissionRepo {
  Future<Either<Failures, AdminSettingsEntity>> getCommission();
}