import 'package:either_dart/either.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/features/client/domain/repos/my_jobs/my_jobs_repo.dart';
import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetOffersForOrderUseCase {
    final MyJobsRepo myJobsRepo;
    GetOffersForOrderUseCase(this.myJobsRepo);

    Future<Either<Failures, List<OfferEntity>>> call(String orderId) => myJobsRepo.getOffers(orderId);  
}