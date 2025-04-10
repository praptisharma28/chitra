class PaymentModel {
  final String id;
  final double amount;
  final DateTime date;
  final String planName;
  final String status; // 'success', 'failed', 'pending'

  PaymentModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.planName,
    required this.status,
  });
}
