
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/admin_settings_entity/admin_settings_entity.dart';
import '../../repos/offer_repository/get_commission_repo/get_commission_repo.dart';
@injectable
class GetCommissionUseCase {
  final GetCommissionRepo getCommissionRepo;

  GetCommissionUseCase({required this.getCommissionRepo});

  Future<Either<Failures, AdminSettingsEntity>> call() async {
    return await getCommissionRepo.getCommission();
  }
}