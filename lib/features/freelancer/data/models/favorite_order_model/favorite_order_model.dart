
import '../../../domain/entities/favorite_order_entity/favorite_order_entity.dart';

class FavoriteOrderModel extends FavoriteOrderEntity {
    FavoriteOrderModel({
    required super.id,
    required super.userId,
    required super.orderId,
    required super.createdAt,
  });

  /// fromJson لتحويل داتا Supabase -> Dart
  factory FavoriteOrderModel.fromJson(Map<String, dynamic> json) {
    return FavoriteOrderModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      orderId: json['order_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// toJson لتحويل Dart -> Map (لما تضيف داتا في Supabase)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'order_id': orderId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
