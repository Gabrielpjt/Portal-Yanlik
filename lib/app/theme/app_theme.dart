import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.backgroundPrimary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.brandPrimary,
        onPrimary: Colors.white,
        secondary: AppColors.guide600,
        onSecondary: Colors.white,
        surface: AppColors.backgroundPrimary,
        onSurface: AppColors.contentPrimary,
        error: Colors.red,
        onError: Colors.white,
        outline: AppColors.strokePrimary,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.contentPrimary),
        bodyMedium: TextStyle(color: AppColors.contentSecondary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundPrimary,
        foregroundColor: AppColors.contentPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: AppColors.backgroundPrimary,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.strokePrimary),
        ),
        elevation: 0,
      ),
    );
  }
}
