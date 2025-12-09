import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';
import '../../../../../domain/entities/earings_entity/earings_entity.dart';

abstract class GetEarningRemoteDataSource {
  Future<Either<Failures, EarningsEntity>> getEarnings({required String freelancerId});
}