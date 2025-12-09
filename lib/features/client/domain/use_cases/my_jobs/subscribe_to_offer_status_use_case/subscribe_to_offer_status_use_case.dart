import 'package:taskly/features/client/domain/repos/my_jobs/my_jobs_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class SubscribeToOfferStatusUseCase {
  final MyJobsRepo myJobsRepo;
  SubscribeToOfferStatusUseCase(this.myJobsRepo);
  Stream<int> subscribeToOffers({
    required String orderId,
  }) {
    return myJobsRepo.subscribeToOffers(orderId: orderId, );
  }
}
