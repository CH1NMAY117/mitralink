import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF1A73E8);  // Medical blue
  static const Color accentColor = Color(0xFF41C3B3);   // Teal accent
  static const Color backgroundColor = Color(0xFFF5F9FF);
  static const Color textColor = Color(0xFF2D3142);
  static const Color lightGrey = Color(0xFFE8EAED);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.backgroundColor,
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.accentColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
    );
  }
} 