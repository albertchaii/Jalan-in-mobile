import 'package:flutter/material.dart';


class AppTheme {
  static const Color primaryColor = Color(0xFF8B0000); // Deep red
  static const Color backgroundColor = Color(0xFFFFF7F6); // Off-white/pinkish
  static const Color inputBackgroundColor = Color(0xFFFCEAE8); // Light pinkish for text fields
  static const Color textColor = Color(0xFF2C1E1C);
  static const Color textLightColor = Color(0xFF755E5C);
  static const Color statusDilaporkan = Color(0xFFD32F2F);
  static const Color statusDiproses = Color(0xFF1976D2);
  static const Color statusSelesai = Color(0xFF388E3C);
  static const Color statusDisurvei = Color(0xFFFBC02D);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        background: backgroundColor,
      ),
      textTheme: const TextTheme().copyWith(
        displayLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: textColor, fontWeight: FontWeight.w700),
        titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textLightColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputBackgroundColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 1.5),
        ),
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 14,
        ),
        labelStyle: TextStyle(
          color: textLightColor,
          fontSize: 14,
        ),
        prefixIconColor: textLightColor,
        suffixIconColor: textLightColor,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: primaryColor),
        titleTextStyle: TextStyle(
          color: primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

