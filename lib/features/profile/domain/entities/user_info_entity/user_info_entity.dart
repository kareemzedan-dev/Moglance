
class UserInfoResponseEntity {
  final UserInfoEntity? user;
  final String? message;

  UserInfoResponseEntity({
    this.user,
    this.message,
  });
}

class UserInfoEntity {
  final String id;
  final String? fullName;
  final String email;
  final String? phoneNumber;
  final String role;
  final String? profileImage;
  final String? bio;
  final List<String>? skills;
  final double? hourlyRate;
  final double ? rating;
  final String?   clientStatus;
  final String?   freelancerStatus;
  final DateTime? lastSeen;
  final bool? isOnline;
  final int ? jobsCount;
  final int ? reviewsCount;
  final double ? freelancerBalance;
  final String? lastMessage;
  final DateTime? lastMessageTime;



  final DateTime? createdAt;
  final BillingInfo? billingInfo;
  final double? balance;
  final DateTime? updatedAt;
  final bool? isVerified;
  final double?totalEarnings;

  UserInfoEntity({
    required this.id,
    this.fullName,
    required this.email,
    this.phoneNumber,
    required this.role,
    this.profileImage,
    this.bio,
    this.skills,
    this.rating,
    this.billingInfo,
    this.balance,
    this.hourlyRate,
    this.createdAt,
    this.updatedAt,
    this.clientStatus,
    this.freelancerStatus,

    this.lastSeen,
    this.isOnline,
    this.jobsCount,
    this.reviewsCount,
    this.freelancerBalance,
    this.isVerified,
    this.totalEarnings,
    this.lastMessage,
    this.lastMessageTime,
  });
}
class BillingInfo {
  final String name;
  final String address;
  final String paymentMethod;

  BillingInfo({
    required this.name,
    required this.address,
    required this.paymentMethod,
  });

  factory BillingInfo.fromJson(Map<String, dynamic> json) {
    return BillingInfo(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'paymentMethod': paymentMethod,
    };
  }
}
