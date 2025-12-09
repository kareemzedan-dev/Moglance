
import '../../../../../../../../profile/domain/entities/user_info_entity/user_info_entity.dart';

class FetchAllFreelancersViewModelStates {}

class FreelancersViewModelStatesInitial extends FetchAllFreelancersViewModelStates {}

class FreelancersViewModelStatesLoading extends FetchAllFreelancersViewModelStates {}

class FreelancersViewModelStatesError extends FetchAllFreelancersViewModelStates {
  final String message;
  FreelancersViewModelStatesError(this.message);
}

class FreelancersViewModelStatesSuccess extends FetchAllFreelancersViewModelStates {
  final List<UserInfoEntity> freelancers;
  FreelancersViewModelStatesSuccess(this.freelancers);
}
