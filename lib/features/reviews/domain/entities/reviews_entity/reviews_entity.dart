class ReviewsEntity {
  final String id;
  final String freelancerId;
  final String clientId;
  final String orderId;
  final String comment;
final String role;
  final String rating;
  final DateTime createdAt;
  ReviewsEntity({
    required this.id,
    required this.freelancerId,
    required this.clientId,
    required this.orderId,
    required this.comment,
    required this.rating,
    required this.createdAt,
    required this.role
  });
}