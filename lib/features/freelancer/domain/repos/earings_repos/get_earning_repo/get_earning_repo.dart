import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../entities/earings_entity/earings_entity.dart';

abstract class GetTotalEarningRepo {
  Future<Either<Failures, EarningsEntity>> getEarnings({required String freelancerId});
}