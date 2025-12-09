import '../../../domain/entities/earings_entity/earings_entity.dart';

class EarningsModel extends EarningsEntity {
  EarningsModel({
    required double balance,
    required double totalEarnings,
    int completedOrders = 0,
    int totalOrders = 0,
  }) : super(
    balance: balance,
    totalEarnings: totalEarnings,
    completedOrders: completedOrders,
    totalOrders: totalOrders,
  );

  // From JSON (parsing from API)
  factory EarningsModel.fromJson(Map<String, dynamic> json) {
    return EarningsModel(
      balance: (json['freelancer_balance'] ?? 0).toDouble(),
      totalEarnings: (json['total_earnings'] ?? 0).toDouble(),
      completedOrders: json['completed_orders'] ?? 0,
      totalOrders: json['total_orders'] ?? 0,
    );
  }

  // To JSON (sending to API)
  Map<String, dynamic> toJson() {
    return {
      'freelancer_balance': balance,
      'total_earnings': totalEarnings,
      'completed_orders': completedOrders,
      'total_orders': totalOrders,
    };
  }

  // Optional: convert from entity
  factory EarningsModel.fromEntity(EarningsEntity entity) {
    return EarningsModel(
      balance: entity.balance,
      totalEarnings: entity.totalEarnings,
      completedOrders: entity.completedOrders,
      totalOrders: entity.totalOrders,
    );
  }

  // Optional: convert to entity
  EarningsEntity toEntity() {
    return EarningsEntity(
      balance: balance,
      totalEarnings: totalEarnings,
      completedOrders: completedOrders,
      totalOrders: totalOrders,
    );
  }
}
