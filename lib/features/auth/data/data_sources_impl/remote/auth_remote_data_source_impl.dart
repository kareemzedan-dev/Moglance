import 'package:either_dart/src/either.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/cache/shared_preferences.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/features/auth/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/services/fcm_service.dart';
import '../../../../../core/utils/constants_manager.dart';
import '../../../../../core/utils/network_utils.dart';
import '../../../../../core/utils/strings_manager.dart';
import '../../../domain/entities/google_response_entity/google_response_entity.dart';
import '../../models/google_response_dm/google_response_dm.dart';
import '../../models/login_response_dm/login_response_dm.dart';
import '../../models/register_response_dm/register_response_dm.dart';

import 'package:taskly/core/errors/supabase_auth_error_mapper.dart';


@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FcmService _fcmService = FcmService();
  final SupabaseService supabaseService;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: ConstantsManager.supabaseServerClientId,
    scopes: ['email', 'profile'],
  );

  AuthRemoteDataSourceImpl(this.supabaseService);

  Future<void> _saveUserLocally({
    required String token,
    required String id,
    required String fullName,
    required String email,
    required String role,
    String? profileImage,
    String? rating,
  }) async {
    await SharedPrefHelper.setString(StringsManager.tokenKey, token);
    await SharedPrefHelper.setString(StringsManager.idKey, id);
    await SharedPrefHelper.setString(StringsManager.fullNameKey, fullName);
    await SharedPrefHelper.setString(StringsManager.emailKey, email);
    await SharedPrefHelper.setString(StringsManager.roleKey, role);
    await SharedPrefHelper.setString(StringsManager.ratingKey, rating ?? "0.0");
    await SharedPrefHelper.setString(StringsManager.phoneNumberKey, "");
    await SharedPrefHelper.setString(
        StringsManager.profileImageKey, profileImage ?? "");
  }

  Future<void> _saveUserToSupabase({
    required String id,
    required String fullName,
    required String email,
    required String role,
    String? avatarUrl,
  }) async {
    final existingUser =
    await supabase.from('users').select().eq('id', id).maybeSingle();

    if (existingUser == null) {
      await supabaseService.sendDataToSupabase(
        tableName: 'users',
        data: {
          'id': id,
          'full_name': fullName,
          'email': email,
          'role': role,
          'profile_image': avatarUrl,
          'rating': 0.0,
          'jobs_count': 0,
          'reviews_count': 0,
          'total_earnings': 0.0,
        },
        conflictColumn: 'email',
      );
    }
  }

  Future<void> _insertRoleData(String id, String role) async {
    final now = DateTime.now().toIso8601String();

    if (role == StringsManager.clientRole) {
      final existingClient =
      await supabase.from('clients').select().eq('id', id).maybeSingle();

      if (existingClient == null) {
        await supabaseService.sendDataToSupabase(
          tableName: 'clients',
          data: {
            'id': id,
            'billing_info': '',
            'balance': 0,
            'created_at': now,
          },
          conflictColumn: 'id',
        );
      }
    } else if (role == StringsManager.freelancerRole) {
      final existingFreelancer = await supabase
          .from('freelancers')
          .select()
          .eq('id', id)
          .maybeSingle();

      if (existingFreelancer == null) {
        await supabaseService.sendDataToSupabase(
          tableName: 'freelancers',
          data: {
            'id': id,
            'is_verified': false,
            'freelancer_status': 'Active',
            'freelancer_balance': 0.0,
            'created_at': now,
          },
          conflictColumn: 'id',
        );
      }
    }
  }

  Future<void> _handleUserAfterAuth({
    required String id,
    required String fullName,
    required String email,
    required String token,
    required String role,
    String? avatarUrl,
    String? rating,
  }) async {
    final userData =
    await supabase.from('users').select().eq('id', id).maybeSingle();

    final actualRating = userData?['rating']?.toString() ?? rating ?? "0.0";

    await _saveUserLocally(
      id: id,
      fullName: fullName,
      email: email,
      token: token,
      role: role,
      profileImage: avatarUrl,
      rating: actualRating,
    );

    await _saveUserToSupabase(
      id: id,
      fullName: fullName,
      email: email,
      role: role,
      avatarUrl: avatarUrl,
    );

    await _insertRoleData(id, role);
  }

  // ========================= Register =========================
  @override
  Future<Either<Failures, RegisterResponseDm>> register(
      String firstName,
      String lastName,
      String email,
      String password,
      String role,
      ) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'role': role,
        },
      );

      if (response.user != null && response.session == null) {
        return Left(ServerFailure(
          SupabaseAuthErrorMapper.parse("Email not confirmed"),
        ));
      }

      final user = response.user!;
      final token = response.session?.accessToken ?? '';

      await _handleUserAfterAuth(
        id: user.id,
        fullName: "$firstName $lastName",
        email: user.email!,
        token: token,
        role: role,
      );

      await _fcmService.registerDeviceToken(user.id);

      final userDm = UserDm(
        firstName: firstName,
        lastName: lastName,
        email: user.email,
        password: password,
        role: role,
      );

      return Right(
        RegisterResponseDm(
          user: userDm,
          message: StringsManager.userRegisteredSuccessfully,
          token: token,
        ),
      );
    } catch (e, s) {
      final friendly = SupabaseAuthErrorMapper.handleError(e, s);
      return Left(ServerFailure(friendly));
    }
  }

  // ========================= Login =========================
  @override
  Future<Either<Failures, LoginResponseDm>> login(
      String email,
      String password,
      String role,
      ) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null || response.session == null) {
        return Left(ServerFailure(
            SupabaseAuthErrorMapper.parse("Invalid login credentials")));
      }

      final user = response.user!;
      final userRole = user.userMetadata?['role'] ?? '';

      if (userRole != role) {
        return Left(
          ServerFailure(
            StringsManager.notRegisteredAsRole,
            params: {"role": role},
          ),
        );
      }

      final userData =
      await supabase.from('users').select().eq('id', user.id).maybeSingle();

      final fullName = userData?['full_name'] ?? '';

      await _handleUserAfterAuth(
        id: user.id,
        fullName: fullName,
        email: user.email ?? '',
        token: response.session!.accessToken,
        role: role,
        rating: userData?['rating']?.toString(),
        avatarUrl: userData?['profile_image'],
      );

      await _fcmService.registerDeviceToken(user.id);

      return Right(
        LoginResponseDm(
          user: LoginUserDm(email: user.email, password: password),
          message: StringsManager.userLoginSuccessfully,
          token: response.session!.accessToken,
        ),
      );
    } catch (e, s) {
      final friendly = SupabaseAuthErrorMapper.handleError(e, s);
      return Left(ServerFailure(friendly));
    }
  }

  // ========================= Google Login =========================
  @override
  Future<Either<Failures, SocialAuthResponseEntity>> googleLogin(
      String role) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      final account = await _googleSignIn.signIn();
      if (account == null) {
        return const Left(ServerFailure(StringsManager.googleLoginCancelled));
      }

      final googleAuth = await account.authentication;

      final res = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken,
      );

      if (res.user == null || res.session == null) {
        return Left(ServerFailure(
            SupabaseAuthErrorMapper.parse("Invalid login credentials")));
      }

      final supabaseUser = res.user!;
      final supabaseToken = res.session!.accessToken;

      final existingUser = await supabase
          .from('users')
          .select()
          .eq('email', account.email)
          .maybeSingle();

      if (existingUser != null && existingUser['role'] != role) {
        return Left(
          ServerFailure(
            StringsManager.accountAlreadyRegistered,
            params: {
              "existingRole": existingUser['role'],
              "role": role,
            },
          ),
        );
      }

      final userId = existingUser != null
          ? existingUser['id']
          : supabaseUser.id;

      await _handleUserAfterAuth(
        id: userId,
        fullName: account.displayName ?? '',
        email: account.email,
        token: supabaseToken,
        role: role,
        avatarUrl: account.photoUrl,
      );

      await _fcmService.registerDeviceToken(userId);

      return Right(
        GoogleAuthResponseDm(
          token: supabaseToken,
          user: GoogleUserDm(
            id: userId,
            name: account.displayName ?? "",
            email: account.email,
            role: role,
            avatarUrl: account.photoUrl,
          ),
          message: StringsManager.googleLoginSuccessful,
        ),
      );
    } catch (e, s) {
      final friendly = SupabaseAuthErrorMapper.handleError(e, s);
      return Left(ServerFailure(friendly));
    }
  }

  // ========================= Apple Login =========================
  @override
  Future<Either<Failures, SocialAuthResponseEntity>> appleLogin(
      String role) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      final res = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: credential.identityToken!,
        accessToken: credential.authorizationCode,
      );

      if (res.user == null || res.session == null) {
        return Left(ServerFailure(
            SupabaseAuthErrorMapper.parse("Invalid login credentials")));
      }

      final supabaseUser = res.user!;
      final token = res.session!.accessToken;

      final email = credential.email ?? '';
      final fullName =
      "${credential.givenName ?? ''} ${credential.familyName ?? ''}".trim();

      final existingUser = await supabase
          .from('users')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (existingUser != null && existingUser['role'] != role) {
        return Left(
          ServerFailure(
            StringsManager.accountAlreadyRegistered,
            params: {
              "existingRole": existingUser['role'],
              "role": role,
            },
          ),
        );
      }

      final userId =
      existingUser != null ? existingUser['id'] : supabaseUser.id;

      await _handleUserAfterAuth(
        id: userId,
        fullName: fullName,
        email: email,
        token: token,
        role: role,
        avatarUrl: null,
      );

      await _fcmService.registerDeviceToken(userId);

      return Right(
        GoogleAuthResponseDm(
          token: token,
          user: GoogleUserDm(
            id: userId,
            name: fullName,
            email: email,
            role: role,
            avatarUrl: null,
          ),
          message: StringsManager.appleLoginSuccessful,
        ),
      );
    } catch (e, s) {
      final friendly = SupabaseAuthErrorMapper.handleError(e, s);
      return Left(ServerFailure(friendly));
    }
  }

  // ========================= Facebook Login =========================
  @override
  Future<Either<Failures, SocialAuthResponseEntity>> facebookLogin(
      String role) async {
    try {
      if (!await NetworkUtils.hasInternet()) {
        return const Left(NetworkFailure(StringsManager.noInternetConnection));
      }

      final result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status != LoginStatus.success ||
          result.accessToken == null) {
        return const Left(ServerFailure(StringsManager.facebookLoginCancelled));
      }

      final fbData = await FacebookAuth.instance.getUserData(
        fields: "email,name,picture.width(200)",
      );

      final email = fbData['email'] ?? '';
      final fullName = fbData['name'] ?? '';
      final avatarUrl = fbData['picture']['data']['url'];

      final existingUser = await supabase
          .from('users')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (existingUser != null && existingUser['role'] != role) {
        return Left(
          ServerFailure(
            StringsManager.accountAlreadyRegistered,
            params: {
              "existingRole": existingUser['role'],
              "role": role,
            },
          ),
        );
      }

      final String userId =
      existingUser != null ? existingUser['id'] : const Uuid().v4();

      if (existingUser == null) {
        await supabase.from('users').insert({
          'id': userId,
          'full_name': fullName,
          'email': email,
          'role': role,
          'profile_image': avatarUrl,
          'created_at': DateTime.now().toIso8601String(),
          'total_earnings': 0.0,
        });
      }

      await _insertRoleData(userId, role);

      await _handleUserAfterAuth(
        id: userId,
        fullName: fullName,
        email: email,
        token: result.accessToken!.tokenString,
        role: role,
        avatarUrl: avatarUrl,
      );

      await _fcmService.registerDeviceToken(userId);

      return Right(
        GoogleAuthResponseDm(
          token: result.accessToken!.tokenString,
          user: GoogleUserDm(
            id: userId,
            name: fullName,
            email: email,
            role: role,
            avatarUrl: avatarUrl,
          ),
          message: StringsManager.facebookLoginSuccessful,
        ),
      );
    } catch (e, s) {
      final friendly = SupabaseAuthErrorMapper.handleError(e, s);
      return Left(ServerFailure(friendly));
    }
  }
}
