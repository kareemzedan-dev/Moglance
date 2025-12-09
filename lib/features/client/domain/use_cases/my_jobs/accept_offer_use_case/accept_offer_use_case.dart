import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/repos/my_jobs/my_jobs_repo.dart';
import 'package:taskly/features/shared/domain/entities/order_entity/order_entity.dart';
import 'package:injectable/injectable.dart';
@injectable
class AcceptOfferUseCase {
   final MyJobsRepo myJobsRepo;

  AcceptOfferUseCase(this.myJobsRepo);
  
  Future<Either<Failures, OrderEntity>> acceptOfferAndRejectOthers(
    String orderId,
    String offerId,
  ) {
    return myJobsRepo.acceptOfferAndRejectOthers(orderId, offerId);
  }
}