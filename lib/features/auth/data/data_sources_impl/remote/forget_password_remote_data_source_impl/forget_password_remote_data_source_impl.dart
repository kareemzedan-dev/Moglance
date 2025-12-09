import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import '../../../../../../core/utils/network_utils.dart';
import '../../../../../../core/utils/strings_manager.dart';
import '../../../data_sources/remote/forget_password_remote_data_source/forget_password_remote_data_source.dart';

@Injectable(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordRemoteDataSourceImpl implements ForgetPasswordRemoteDataSource {
  final SupabaseClient supabase;

  ForgetPasswordRemoteDataSourceImpl(this.supabase);

  @override
  Future<Either<Failures, void>> forgetPassword(String email) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      await supabase.auth.resetPasswordForEmail(email);

      return Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
