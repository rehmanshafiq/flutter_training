import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'fonts.dart';

class AppTheme {
  static ThemeData get getTheme {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      secondaryHeaderColor: AppColors.secondaryColor,
      scaffoldBackgroundColor: AppColors.primaryColor,

      textTheme: const TextTheme(
        displayLarge: AppFonts.headingStyle,
        displayMedium: AppFonts.mediumHeadingStyle,
        labelLarge: AppFonts.buttonStyle,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),

      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
