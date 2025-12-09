import 'package:taskly/features/client/domain/entities/home/service_response_entity.dart';

class ServicesViewModelStates {}

class ServicesViewModelStatesInitial extends ServicesViewModelStates {}

class ServicesViewModelStatesLoading extends ServicesViewModelStates {}

class ServicesViewModelStatesError extends ServicesViewModelStates {
  final String error;
  ServicesViewModelStatesError(this.error);
}

class ServicesViewModelStatesSuccess extends ServicesViewModelStates {
  final List<ServiceEntity> services;
  ServicesViewModelStatesSuccess(this.services);
}