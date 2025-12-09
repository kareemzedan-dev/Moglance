import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taskly/core/errors/failures.dart';
import 'package:taskly/core/services/supabase_service.dart';
import 'package:taskly/features/profile/data/data_sources/profile_remote_data_source.dart';
import '../../domain/entities/user_info_entity/user_info_entity.dart';
import '../models/user_info_dm/user_info_response_dm.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final SupabaseService supabaseService;
  final SupabaseClient _client = Supabase.instance.client;

  ProfileRemoteDataSourceImpl(this.supabaseService);

  @override
  Future<Either<Failures, UserInfoDm>> getUserInfo(
    String userId,
    String role,
  ) async {
    try {
      if (userId.isEmpty) {
        return const Left(ServerFailure("User not logged in"));
      }

      final userResponse = await _client
          .from('users')
          .select()
          .eq('id', userId)
          .maybeSingle();

      Map<String, dynamic>? extraResponse;

      if (role == "client") {
        extraResponse = await _client
            .from('clients')
            .select()
            .eq('id', userId)
            .maybeSingle();
      } else if (role == "freelancer") {
        extraResponse = await _client
            .from('freelancers')
            .select()
            .eq('id', userId)
            .maybeSingle();
      }

      final user = UserInfoDm(
        id: userResponse?['id'] ?? "",
        fullName: userResponse?['full_name'] ?? "Unknown",
        email: userResponse?['email'] ?? "Unknown",
        phoneNumber: userResponse?['phone_number'] ?? "",
        role: userResponse?['role'] ?? "",
        profileImage: userResponse?['profile_image'],
        bio: userResponse?['bio'],
        totalEarnings: userResponse?['total_earnings'] != null
          ? (userResponse?['total_earnings'] as num).toDouble() : 0.0,

        createdAt: userResponse?['created_at'] != null
            ? DateTime.tryParse(userResponse?['created_at'])
            : null,
        rating: _parseDouble(userResponse?['rating']) ?? 0.0,

        billingInfo: role == "client" &&
                extraResponse?['billing_info'] != null &&
                extraResponse!['billing_info'].toString().isNotEmpty
            ? BillingInfo.fromJson(jsonDecode(extraResponse['billing_info']))
            : null,
        balance: role == "client" ? (extraResponse?['balance'] ?? 0) : null,
        skills: role == "freelancer" && extraResponse?['skills'] != null
            ? List<String>.from(extraResponse?['skills'] as List)
            : null,
        hourlyRate: role == "freelancer" && extraResponse?['hourly_rate'] != null
            ? (extraResponse?['hourly_rate'] as num).toDouble()
            : null,
        freelancerBalance: role == "freelancer"
            ? _parseDouble(extraResponse?['freelancer_balance']) ?? 0.0
            : 0.0,
        freelancerStatus:
            role == "freelancer" ? (extraResponse?['freelancer_status'] ?? '') : '',
        clientStatus:
            role == "client" ? (extraResponse?['client_status'] ?? '') : '',
        isVerified:
            role == "freelancer" ? (extraResponse?['is_verified'] ?? false) : false,
        isOnline: userResponse?['is_online'] ?? false,
        jobsCount: userResponse?['jobs_count']?.toInt() ?? 0,
        lastSeen: userResponse?['last_seen'] != null
            ? DateTime.tryParse(userResponse!['last_seen'].toString())
            : null,
        reviewsCount: userResponse?['reviews_count']?.toInt() ?? 0,

      );

      return Right(user);
    } catch (e) {
      return Left(ServerFailure("Failed to fetch user info: $e"));
    }
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
