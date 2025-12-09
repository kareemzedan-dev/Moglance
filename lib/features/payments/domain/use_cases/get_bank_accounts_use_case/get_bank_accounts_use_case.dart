import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:taskly/features/payments/data/repositories/get_bank_accounts_repo_impl/get_bank_accounts_repo_impl.dart';

import '../../../../../core/errors/failures.dart';
import '../../entities/bank_accounts_entity/bank_accounts_entity.dart';
import '../../repositories/get_bank_account_repos/get_bank_account_repos.dart';
@injectable
class GetBankAccountsUseCase {
  final GetBankAccountsRepos repository;

  GetBankAccountsUseCase(this.repository);

  Stream<Either<Failures, List<BankAccountsEntity>>> call() {
    return repository.getBankAccounts();
  }
}
