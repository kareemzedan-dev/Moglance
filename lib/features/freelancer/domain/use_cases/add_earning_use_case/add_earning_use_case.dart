import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../repos/earings_repos/add_earing_repo/add_earing_repo.dart';

@injectable
class AddEarningUseCase {
  final AddEarningRepo addEarningRepo;
  AddEarningUseCase({required this.addEarningRepo});
  Future<Either<Failures, void>> addEarning({required String freelancerId, required double amount, required String clientId,}) => addEarningRepo.addEarning(freelancerId: freelancerId, amount: amount,clientId: clientId);
}