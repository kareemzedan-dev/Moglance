
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../domain/repos/earings_repos/add_earing_repo/add_earing_repo.dart';
import '../../../data_sources/remote/earings_remote_data_source/add_earning_remote_data_source/add_earning_remote_data_source.dart';
@Injectable(as:  AddEarningRepo)
class AddEarningRepoImpl implements AddEarningRepo {
  final AddEarningRemoteDataSource addEarningRemoteDataSource;
 AddEarningRepoImpl({required this.addEarningRemoteDataSource});
 @override
  Future<Either<Failures, void>> addEarning({required String freelancerId, required double amount, required String clientId,}) {
   return addEarningRemoteDataSource.addEarning(freelancerId: freelancerId, amount: amount,clientId: clientId);
 }
}