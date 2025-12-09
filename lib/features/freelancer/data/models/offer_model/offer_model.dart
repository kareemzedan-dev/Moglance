import 'package:taskly/features/freelancer/domain/entities/offer_entity/offer_entity.dart';
class OfferModel extends OfferEntity {
  OfferModel({
    required super.id,
    required super.freelancerId,
    required super.clientId,
    required super.orderId,
    required super.offerAmount,    
    required super.offerStatus,
    required super.offerDescription,
    required super.offerDeliveryTime, 
    required super.createdAt,
    required super.updatedAt,
    required super.orderName,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] as String,
      freelancerId: json['freelancer_id'] as String,
      clientId: json['client_id'] as String,
      orderId: json['order_id'] as String,
      offerAmount: (json['price'] as num).toDouble(),   // ✅ double
      offerStatus: json['status'] as String,
      offerDescription: json['description'] as String,
      offerDeliveryTime: json['delivery_time'] as int,  // ✅ int
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      orderName: json['order_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'freelancer_id': freelancerId,
      'client_id': clientId,
      'order_id': orderId,
      'price': offerAmount,           
      'status': offerStatus,
      'description': offerDescription,
      'delivery_time': offerDeliveryTime,  
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'order_name': orderName,
    };
  }

   OfferEntity toEntity() {
    return OfferEntity(
      id: id,
      freelancerId: freelancerId,
      clientId: clientId,
      orderId: orderId,
      offerAmount: offerAmount,
      offerStatus: offerStatus,
      offerDescription: offerDescription,
      offerDeliveryTime: offerDeliveryTime,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderName: orderName,
    );
  }
}

