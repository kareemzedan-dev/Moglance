
import 'package:either_dart/either.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/bank_accounts_entity/bank_accounts_entity.dart';

abstract class GetBankAccountsRepos {
  Stream<Either<Failures, List<BankAccountsEntity>>>  getBankAccounts();
}
