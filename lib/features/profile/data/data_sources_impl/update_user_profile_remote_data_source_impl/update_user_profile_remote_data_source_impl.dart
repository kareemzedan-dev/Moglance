import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/utils/network_utils.dart';

import '../../../../../core/services/supabase_service.dart';
import '../../../../../core/services/upload_profile_image.dart';
import '../../../../../core/utils/strings_manager.dart';
import '../../data_sources/update_user_profile_remote_data_source/update_user_profile_remote_data_source.dart';
@Injectable(as:  UpdateUserProfileRemoteDataSource)
class UpdateUserProfileRemoteDataSourceImpl
    implements UpdateUserProfileRemoteDataSource {
  final SupabaseService supabaseService;

  UpdateUserProfileRemoteDataSourceImpl(this.supabaseService);
  @override
  Future<Either<Failures, void>> updateUserInfo(
      String userId,
      String fullName,
      String email,
      String phoneNumber,
      String profileImagePath) async {
    try {
      if (NetworkUtils.hasInternet() == false) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }
      String? profileImageUrl = profileImagePath;

// لو الصورة موجودة ومسارها محلي (مش URL)، نرفعها
      if (profileImagePath.isNotEmpty && !profileImagePath.startsWith('http')) {
        profileImageUrl = await uploadProfileImage(supabaseService, userId, profileImagePath);
      }

// لو الصورة URL أو فاضية، نستخدم الرابط الحالي بدون upload
      profileImageUrl ??= profileImagePath;


      await supabaseService.updateMultiple(
        table: 'users',
        data: {
          'full_name': fullName,
          'phone_number': phoneNumber,
          'profile_image': profileImageUrl,
        },
        conditions: {'id': userId},
      );


      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

}
