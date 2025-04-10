import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: Colors.white70,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: Colors.white54,
  );

  static BoxDecoration mainBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.gradientStart,
        AppColors.gradientEnd,
      ],
    ),
  );
}
