class EarningsEntity {
  final double balance;
  final double totalEarnings;
  final int completedOrders;
  final int totalOrders;


  EarningsEntity({
    required this.balance,
    required this.totalEarnings,
    this.completedOrders = 0,
    this.totalOrders = 0,
   }) ;
}
