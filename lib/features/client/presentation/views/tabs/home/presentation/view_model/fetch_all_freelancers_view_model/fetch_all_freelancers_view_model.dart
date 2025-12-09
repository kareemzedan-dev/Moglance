import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/use_cases/home/get_all_freelancers_use_case/get_all_freelancers_use_case.dart';
import '../../../../../../../../profile/domain/entities/user_info_entity/user_info_entity.dart';
import 'fetch_all_freelancers_view_model_states.dart';

@injectable
class FetchAllFreelancersViewModel extends Cubit<FetchAllFreelancersViewModelStates> {
  final GetAllFreelancersUseCase freelancerUseCase;

  FetchAllFreelancersViewModel(this.freelancerUseCase)
      : super(FreelancersViewModelStatesInitial());

  List<UserInfoEntity> allFreelancers = [];

  Future<Either<Failures, List<UserInfoEntity>>> getAllFreelancer() async {
    try {
      emit(FreelancersViewModelStatesLoading());
      final result = await freelancerUseCase.callGetFreelancer();

      result.fold(
            (failure) => emit(FreelancersViewModelStatesError(failure.message)),
            (freelancers) {
          allFreelancers = freelancers;
          emit(FreelancersViewModelStatesSuccess(freelancers));
        },
      );
      return result;
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  void searchFreelancers(String query) {
    if (query.isEmpty) {
      emit(FreelancersViewModelStatesSuccess(allFreelancers));
      return;
    }

    final filtered = allFreelancers.where((freelancer) {
      final name = freelancer.fullName!.toLowerCase();
      final skills = freelancer.skills?.join(' ').toLowerCase() ?? '';
      return name.contains(query.toLowerCase()) ||
          skills.contains(query.toLowerCase());
    }).toList();

    emit(FreelancersViewModelStatesSuccess(filtered));
  }
}
