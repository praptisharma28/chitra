import 'package:flutter/material.dart';
import 'package:chitra_ai/constants/app_colors.dart';
import 'package:chitra_ai/constants/app_styles.dart';
import 'package:chitra_ai/models/payment_model.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final List<PaymentModel> _payments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPayments();
  }

  Future<void> _loadPayments() async {
    // Simulated API call
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _payments.addAll([
        PaymentModel(
          id: '1',
          amount: 9.99,
          date: DateTime.now().subtract(const Duration(days: 5)),
          planName: 'Starter Pack',
          status: 'success',
        ),
        PaymentModel(
          id: '2',
          amount: 24.99,
          date: DateTime.now().subtract(const Duration(days: 30)),
          planName: 'Pro Plan',
          status: 'success',
        ),
      ]);
      _isLoading = false;
    });
  }

  Widget _buildPaymentItem(PaymentModel payment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white10,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _statusColor(payment.status).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            _statusIcon(payment.status),
            color: _statusColor(payment.status),
          ),
        ),
        title: Text(
          payment.planName,
          style: AppStyles.bodyText.copyWith(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          _formatDate(payment.date),
          style: AppStyles.caption,
        ),
        trailing: Text(
          '\$${payment.amount.toStringAsFixed(2)}',
          style: AppStyles.bodyText.copyWith(
            color: AppColors.accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'success':
        return Colors.green;
      case 'failed':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'success':
        return Icons.check_circle;
      case 'failed':
        return Icons.error;
      default:
        return Icons.pending;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: AppStyles.mainBackground,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _payments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, size: 64, color: AppColors.accentColor),
                        const SizedBox(height: 16),
                        Text(
                          'No Payment History',
                          style: AppStyles.heading,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your transactions will appear here',
                          style: AppStyles.bodyText,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _payments.length,
                    itemBuilder: (context, index) => _buildPaymentItem(_payments[index]),
                  ),
      ),
    );
  }
}
