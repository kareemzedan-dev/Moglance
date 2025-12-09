import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/entities/earings_entity/earings_entity.dart';
import '../../../../domain/repos/earings_repos/get_earning_repo/get_earning_repo.dart';
import '../../../data_sources/remote/earings_remote_data_source/get_earning_remote_data_source/get_earning_remote_data_source.dart';
@Injectable(as:  GetTotalEarningRepo)
class GetEarningRepoImpl implements GetTotalEarningRepo {
  final GetEarningRemoteDataSource getTotalEarningRemoteDataSource;
  GetEarningRepoImpl({required this.getTotalEarningRemoteDataSource});
  @override
  Future<Either<Failures, EarningsEntity>> getEarnings({required String freelancerId}) {
    return getTotalEarningRemoteDataSource.getEarnings(freelancerId: freelancerId);
  }

}