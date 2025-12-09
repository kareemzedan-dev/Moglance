import 'package:either_dart/either.dart';
 
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/repos/my_jobs/my_jobs_repo.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:injectable/injectable.dart';
@injectable
class UpdateOfferStatusUseCase {
    final MyJobsRepo myJobsRepo;
    UpdateOfferStatusUseCase(this.myJobsRepo);
    
  Future<Either<Failures, OfferEntity>> updateOfferStatus(
    String offerId,
    String newStatus,
  ) {
    return myJobsRepo.updateOfferStatus(offerId, newStatus);
  }

}