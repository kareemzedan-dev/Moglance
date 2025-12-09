import 'package:either_dart/either.dart';

import '../../../../../../core/errors/failures.dart';

abstract class AddEarningRepo {
  Future<Either<Failures, void>> addEarning({required String freelancerId, required double amount, required String clientId,});
}