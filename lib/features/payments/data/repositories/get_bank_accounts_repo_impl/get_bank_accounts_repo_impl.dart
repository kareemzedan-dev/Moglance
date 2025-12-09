import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/bank_accounts_entity/bank_accounts_entity.dart';
import '../../../domain/repositories/get_bank_account_repos/get_bank_account_repos.dart';
import '../../data_sources/remote/get_bank_accounts_remote_data_source/get_bank_accounts_remote_data_source.dart';

@Injectable(as: GetBankAccountsRepos)
class GetBankAccountsRepoImpl implements GetBankAccountsRepos {
  final GetBankAccountsRemoteDataSource remote;

  GetBankAccountsRepoImpl(this.remote);

  @override
  Stream<Either<Failures, List<BankAccountsEntity>>> getBankAccounts() {
    return remote.subscribeToBankAccounts().map((result) {
      return result.fold(
            (failure) => Left(failure),
            (models) => Right(models.map((m) => m.toEntity()).toList()),
      );
    });
  }
}
