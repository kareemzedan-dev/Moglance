class OfferEntity {
  final String id;
  final String freelancerId;
  final String clientId;
  final String orderId;
  final double offerAmount;
  final String offerStatus;
  final String offerDescription;

  final int offerDeliveryTime;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? freelancerRating;
  final String?orderName ;

  OfferEntity({
    required this.id,
    required this.freelancerId,
    required this.clientId,
    required this.orderId,
    required this.offerAmount,
    required this.offerStatus,
    required this.offerDescription,
    required this.offerDeliveryTime,
    required this.createdAt,
    required this.updatedAt,
    this.freelancerRating,
    required this.orderName
  });
}