import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/freelancer/domain/use_cases/get_commission_use_case/get_commission_use_case.dart';

import '../../../../../../../domain/entities/admin_settings_entity/admin_settings_entity.dart';
import 'get_commission_sates.dart';
@injectable
class GetCommissionViewModel extends Cubit<GetCommissionSates> {
  final GetCommissionUseCase getCommissionUseCase;
  AdminSettingsEntity? _adminSettings;

  GetCommissionViewModel(this.getCommissionUseCase)
      : super(GetCommissionSatesInitial());

  Future<void> getCommission() async {
    try {
      emit(GetCommissionSatesLoading());
      var result = await getCommissionUseCase.call();
      result.fold(
            (failure) => emit(GetCommissionSatesError(message: failure.message)),
            (commission) {
          _adminSettings = commission;
          emit(GetCommissionSatesSuccess(adminSettingsEntity: commission));
        },
      );
    } catch (e) {
      emit(GetCommissionSatesError(message: e.toString()));
    }
  }


  double calculatePriceAfterCommission(double amount) {
    if (_adminSettings == null) return amount;
    final commissionPercentage = _adminSettings!.commission;
    final discountedAmount = amount * (1 - commissionPercentage / 100);
    return discountedAmount;
  }
}
