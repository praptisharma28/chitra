import 'package:flutter/material.dart';
import 'package:chitra_ai/constants/app_colors.dart';
import 'package:chitra_ai/constants/app_styles.dart';
import 'package:chitra_ai/models/image_model.dart';

class ImageResultScreen extends StatelessWidget {
  final ImageModel imageData;

  const ImageResultScreen({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareImage(),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _saveImage(),
          ),
        ],
      ),
      body: Container(
        decoration: AppStyles.mainBackground,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildImageSection(),
              const SizedBox(height: 24),
              _buildPromptSection(),
              const SizedBox(height: 24),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentColor.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imageData.resultPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildPromptSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Prompt Used:',
            style: AppStyles.caption.copyWith(color: AppColors.accentColor),
          ),
          const SizedBox(height: 8),
          Text(
            imageData.prompt,
            style: AppStyles.bodyText,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.refresh),
          label: const Text('Regenerate'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accentColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () {},
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.shopping_cart),
          label: const Text('Buy Credits'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white10,
            foregroundColor: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  void _shareImage() {
    // Implement share functionality
  }

  void _saveImage() {
    // Implement save functionality
  }
}
