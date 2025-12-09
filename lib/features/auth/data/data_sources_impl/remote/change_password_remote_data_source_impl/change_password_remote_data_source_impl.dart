import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/utils/network_utils.dart';
import '../../../../../../core/utils/strings_manager.dart';
import '../../../data_sources/remote/change_password_remote_data_source/change_password_remote_data_source.dart';

@Injectable(as: ChangePasswordRemoteDataSource)
class ChangePasswordRemoteDataSourceImpl implements ChangePasswordRemoteDataSource {
  final SupabaseClient supabase;

  ChangePasswordRemoteDataSourceImpl(this.supabase);

  Future<Either<Failures, void>> changePassword(
      String currentPassword, String newPassword) async {
    try {
      print("Checking internet connection...");
      if (!await NetworkUtils.hasInternet()) {
        print("No internet connection.");
        return Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      final currentUser = supabase.auth.currentUser;
      print("Current user: $currentUser");
      if (currentUser == null || currentUser.email == null) {
        print("User not logged in or email is null");
        return Left(AuthFailure("User not logged in"));
      }

      print("Verifying current password for ${currentUser.email}...");
      final response = await supabase.auth.signInWithPassword(
        email: currentUser.email!,
        password: currentPassword,
      );

      print("Sign in response: $response");

      if (response.session == null) {
        print("Current password is incorrect");
        return Left(AuthFailure("Current password is incorrect"));
      }

      print("Updating password to new password...");
      await supabase.auth.updateUser(UserAttributes(password: newPassword));
      print("Password updated successfully");

      return Right(null);
    } catch (e, stackTrace) {
      print("Exception caught: $e");
      print(stackTrace);
      return Left(ServerFailure(e.toString()));
    }
  }
}
