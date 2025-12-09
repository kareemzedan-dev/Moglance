abstract class UpdateUserStatusRemoteDataSource {
  Future<void> updateUserStatus(String userId, {String? status, bool? isVerified, required String role});
}