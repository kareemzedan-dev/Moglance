import 'package:either_dart/either.dart';

import '../../../../../../../core/errors/failures.dart';


abstract class AddEarningRemoteDataSource {
  Future<Either<Failures, void>> addEarning({required String freelancerId, required double amount, required String clientId,});
}