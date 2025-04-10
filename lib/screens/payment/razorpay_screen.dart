import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:chitra_ai/constants/app_colors.dart';
import 'package:chitra_ai/constants/app_styles.dart';

class RazorpayScreen extends StatefulWidget {
  final double amount;
  final String planName;

  const RazorpayScreen({super.key, required this.amount, required this.planName});

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  late Razorpay _razorpay;
  bool _isLoading = true;
  bool _paymentSuccess = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _initiatePayment();
  }

  void _initiatePayment() async {
    // Initialize payment here with your Razorpay keys
    final options = {
      'key': 'YOUR_RAZORPAY_KEY',
      'amount': widget.amount * 100, // Convert to paise
      'name': 'Chitra.AI',
      'description': widget.planName,
      'prefill': {'contact': '', 'email': ''},
      'theme': {'color': AppColors.accentColor.value}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      setState(() {
        _errorMessage = 'Error initializing payment: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _paymentSuccess = true;
      _isLoading = false;
    });
    // Handle successful payment
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      _errorMessage = 'Payment failed: ${response.message ?? 'Unknown error'}';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: AppStyles.mainBackground,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _paymentSuccess
                  ? _buildSuccessUI()
                  : _buildErrorUI(),
        ),
      ),
    );
  }

  Widget _buildSuccessUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle, color: AppColors.accentColor, size: 80),
        const SizedBox(height: 24),
        Text(
          'Payment Successful!',
          style: AppStyles.heading,
        ),
        const SizedBox(height: 16),
        Text(
          '${widget.planName} plan activated',
          style: AppStyles.bodyText,
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('BACK TO APP'),
        ),
      ],
    );
  }

  Widget _buildErrorUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, color: Colors.red, size: 80),
        const SizedBox(height: 24),
        Text(
          'Payment Failed',
          style: AppStyles.heading.copyWith(color: Colors.red),
        ),
        const SizedBox(height: 16),
        Text(
          _errorMessage,
          style: AppStyles.bodyText,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white10,
              ),
              child: const Text('CANCEL'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _initiatePayment,
              child: const Text('RETRY'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
