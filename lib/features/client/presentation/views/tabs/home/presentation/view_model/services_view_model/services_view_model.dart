import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/entities/home/service_response_entity.dart';
import 'package:taskly/features/client/domain/use_cases/home/get_all_services_use_case/get_all_services_use_case.dart';
import 'package:taskly/features/client/presentation/views/tabs/home/presentation/view_model/services_view_model/services_view_model_states.dart';
@injectable
class ServicesViewModel extends Cubit<ServicesViewModelStates> {
  final GetAllServicesUseCase servicesUseCase;
    final List<String> categories = [
    "Academic Sources",
    "Scientific Reports",
    "Mind Maps",
    "Translation",
    "Summarization",
    "Scientific Projects",
    "Presentations",
    "SPSS Analysis",
    "Proofreading",
    "Programming",
    "Tutorials",
    "Other",
  ];
  List<ServiceEntity> _allServices = [];

  ServicesViewModel(this.servicesUseCase)
      : super(ServicesViewModelStatesInitial());

  Future<Either<Failures, List<ServiceEntity>>> getServices() async {
    try {
      emit(ServicesViewModelStatesLoading());
      final result = await servicesUseCase.callServices();
      result.fold(
        (failure) => emit(ServicesViewModelStatesError(failure.message)),
        (services) {
          _allServices = services;
          emit(ServicesViewModelStatesSuccess(services));
        },
      );
      return result;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  void searchServices(String query) {
    if (query.isEmpty) {
      emit(ServicesViewModelStatesSuccess(_allServices));
    } else {
      final filtered = _allServices
          .where((service) =>
              service.title.toLowerCase().contains(query.toLowerCase()) ||
              service.buttonText.toLowerCase().contains(query.toLowerCase()))
          .toList();

      emit(ServicesViewModelStatesSuccess(filtered));
    }
  }
}
