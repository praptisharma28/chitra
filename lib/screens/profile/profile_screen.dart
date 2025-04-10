import 'package:flutter/material.dart';
import 'package:chitra_ai/constants/app_colors.dart';
import 'package:chitra_ai/constants/app_styles.dart';
import 'package:chitra_ai/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _navigateToEditProfile(context),
          ),
        ],
      ),
      body: Container(
        decoration: AppStyles.mainBackground,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: user.profileImage != null 
                    ? NetworkImage(user.profileImage!)
                    : null,
                child: user.profileImage == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(user.name, style: AppStyles.heading),
              const SizedBox(height: 8),
              Text(user.email, style: AppStyles.bodyText),
              const SizedBox(height: 24),
              _buildInfoCard('Account Created', _formatDate(user.createdAt)),
              const SizedBox(height: 16),
              _buildInfoCard('AI Credits Remaining', '${user.credits}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _navigateToPaymentHistory(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('VIEW PAYMENT HISTORY'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppStyles.caption),
          const SizedBox(height: 4),
          Text(value, style: AppStyles.bodyText),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _navigateToEditProfile(BuildContext context) {
    Navigator.pushNamed(context, '/edit-profile');
  }

  void _navigateToPaymentHistory(BuildContext context) {
    Navigator.pushNamed(context, '/payment-history');
  }
}
