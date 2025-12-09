import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../entities/earings_entity/earings_entity.dart';
import '../../repos/earings_repos/get_earning_repo/get_earning_repo.dart';
@injectable
  class GetEarningUseCase {
    final GetTotalEarningRepo getEarningRepo;
    GetEarningUseCase({required this.getEarningRepo});
    Future<Either<Failures, EarningsEntity>> call({required String freelancerId}) => getEarningRepo.getEarnings(freelancerId: freelancerId);

}