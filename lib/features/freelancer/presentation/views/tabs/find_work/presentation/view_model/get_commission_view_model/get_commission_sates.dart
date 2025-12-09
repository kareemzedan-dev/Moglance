
import '../../../../../../../domain/entities/admin_settings_entity/admin_settings_entity.dart';

class GetCommissionSates {}
class GetCommissionSatesInitial extends GetCommissionSates {}

class GetCommissionSatesLoading extends GetCommissionSates {}

class GetCommissionSatesSuccess extends GetCommissionSates {
  final AdminSettingsEntity adminSettingsEntity;
  GetCommissionSatesSuccess({required this.adminSettingsEntity});
}

class GetCommissionSatesError extends GetCommissionSates {
  final String message;
  GetCommissionSatesError({required this.message});
}