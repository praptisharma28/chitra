import 'package:flutter/material.dart';
import 'package:chitra_ai/constants/app_colors.dart';
import 'package:chitra_ai/constants/app_styles.dart';

class PaymentPlansScreen extends StatelessWidget {
  final List<Map<String, dynamic>> plans = [
    {
      'name': 'Starter',
      'price': 9.99,
      'credits': 50,
      'features': ['50 AI generations', 'Basic support', '1 month validity']
    },
    {
      'name': 'Pro',
      'price': 24.99,
      'credits': 150,
      'features': ['150 AI generations', 'Priority support', '3 months validity', 'Early access']
    },
    {
      'name': 'Enterprise',
      'price': 99.99,
      'credits': 500,
      'features': ['500 AI generations', '24/7 support', '6 months validity', 'Custom templates']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Plan'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: AppStyles.mainBackground,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: plans.length,
          itemBuilder: (context, index) => _buildPlanCard(plans[index]),
        ),
      ),
    );
  }

  Widget _buildPlanCard(Map<String, dynamic> plan) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.gradientStart,
            AppColors.gradientEnd,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plan['name'],
                  style: AppStyles.heading.copyWith(fontSize: 28),
                ),
                Text(
                  '\$${plan['price']}',
                  style: AppStyles.heading.copyWith(
                    color: AppColors.accentColor,
                    fontSize: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '${plan['credits']} Credits',
              style: AppStyles.subHeading,
            ),
            const SizedBox(height: 16),
            ...plan['features'].map<Widget>((feature) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.accentColor, size: 18),
                  const SizedBox(width: 8),
                  Text(feature, style: AppStyles.bodyText),
                ],
              ),
            )).toList(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectPlan(plan),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('CHOOSE PLAN'),
            ),
          ],
        ),
      ),
    );
  }

  void _selectPlan(Map<String, dynamic> plan) {
    // Navigate to payment screen
  }
}
