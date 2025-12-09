
import '../../../domain/entities/user_info_entity/user_info_entity.dart';

class UserInfoResponseModel extends UserInfoResponseEntity {
  UserInfoResponseModel({super.user, super.message});

  factory UserInfoResponseModel.fromJson(Map<String, dynamic> json) {
    return UserInfoResponseModel(
      user: json['user'] != null ? UserInfoDm.fromJson(json['user']) : null,
      message: json['message'],
    );
  }
}

class UserInfoDm extends UserInfoEntity {
  UserInfoDm({
    required super.id,
    super.fullName,
    required super.email,
    super.phoneNumber,
    required super.role,
    super.profileImage,
    super.bio,
    super.skills,
    super.hourlyRate,
    super.rating,
    super.createdAt,
    super.billingInfo,
    super.balance,
    super.updatedAt,
    super.isOnline,
    super.jobsCount,
    super.lastSeen,
    super.reviewsCount,
    super.clientStatus,
    super.freelancerStatus,
    super.freelancerBalance,
    super.isVerified,
    super.totalEarnings,
    super.lastMessage,
    super.lastMessageTime,

  });

  factory UserInfoDm.fromJson(Map<String, dynamic> json) {
    return UserInfoDm(
        id: json['uuid'] ?? json['id'] ?? '',   // fallback to empty string
        fullName: json['full_name'] ?? '',
        email: json['email'] ?? '',
        phoneNumber: json['phone_number'],
        role: json['role'] ?? '',
        profileImage: json['profile_image'],
        bio: json['bio'],
        skills: json['skills'] != null
            ? List<String>.from(json['skills'])
            : [],

        hourlyRate: json['hourly_rate'] != null
            ? (json['hourly_rate'] as num).toDouble()
            : null,
        rating: json['rating'] != null
            ? (json['rating'] as num).toDouble()
            : 0.0,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'])
            : null,
        updatedAt: json['updated_at'] != null
            ? DateTime.tryParse(json['updated_at'])
            : null,
        billingInfo: json['billing_info'] != null
            ? BillingInfo.fromJson(json['billing_info'])
            : null,
        balance: json['balance'] != null
            ? (json['balance'] as num).toDouble()
            : 0.0,

        isOnline:  json['is_online'] ?? false,
        jobsCount:  json['jobs_count'] ?? 0,
        lastSeen:  json['last_seen'] != null ? DateTime.tryParse(json['last_seen']) : null,
        reviewsCount:  json['reviews_count'] ?? 0,
        clientStatus: json['client_status'] ?? '',
        freelancerStatus: json['freelancer_status'] ?? '',
        freelancerBalance: json['freelancer_balance'] != null ?
        (json['freelancer_balance'] as num).toDouble() : 0.0,
        isVerified:  json['is_verified'] ?? false,
        totalEarnings: json['total_earnings'] != null ?
            (json['total_earnings'] as num).toDouble() : 0.0,
        lastMessage: json['last_message'] ?? '',
        lastMessageTime: json['last_message_time'] != null ? DateTime.tryParse(json['last_message_time']) : null,




    );
  }


  Map<String, dynamic> toJson() {
    return {
      'uuid': id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'role': role,
      'profile_image': profileImage,
      'bio': bio,
      'skills': skills,
      'rating': rating,
      'hourly_rate': hourlyRate,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'billing_info': billingInfo?.toJson(),
      'balance': balance,
      'is_online': isOnline,
      'jobs_count': jobsCount,
      'last_seen': lastSeen?.toIso8601String(),
      'reviews_count': reviewsCount,

      'freelancer_balance': freelancerBalance,
      'is_verified': isVerified,
      'total_earnings': totalEarnings,
      'last_message': lastMessage,
      'last_message_time': lastMessageTime?.toIso8601String(),

    };
  }

  UserInfoDm copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? role,
    String? profileImage,
    String? bio,
    List<String>? skills,
    double? hourlyRate,
    double? rating,
    DateTime? createdAt,
    BillingInfo? billingInfo,
    double? balance,
    DateTime? updatedAt,
    bool? isOnline,
    int? jobsCount,
    DateTime? lastSeen,
    int? reviewsCount,
    String? clientStatus,
    String? freelancerStatus,
    double? freelancerBalance,
    bool? isVerified,
    double? totalEarnings,
    String? lastMessage,
    DateTime? lastMessageTime,
  }) {
    return UserInfoDm(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        role: role ?? this.role,
        profileImage: profileImage ?? this.profileImage,
        bio: bio ?? this.bio,
        skills: skills ?? this.skills,
        hourlyRate: hourlyRate ?? this.hourlyRate,
        rating: rating ?? this.rating,
        createdAt: createdAt ?? this.createdAt,
        billingInfo: billingInfo ?? this.billingInfo,
        balance: balance ?? this.balance,
        updatedAt: updatedAt ?? this.updatedAt,
        isOnline: isOnline ?? this.isOnline,
        jobsCount: jobsCount ?? this.jobsCount,
        lastSeen: lastSeen ?? this.lastSeen,
        reviewsCount: reviewsCount ?? this.reviewsCount,
        clientStatus: clientStatus ?? this.clientStatus,
        freelancerStatus: freelancerStatus ?? this.freelancerStatus,
        freelancerBalance: freelancerBalance ?? this.freelancerBalance,
        isVerified: isVerified ?? this.isVerified,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
    );
  }
}
