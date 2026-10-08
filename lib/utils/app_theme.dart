import 'package:flutter/material.dart';

class AppTheme {
  // Padel court blue + ball yellow
  static const Color court = Color(0xFF1B4F8F);
  static const Color courtDark = Color(0xFF123A6B);
  static const Color ball = Color(0xFFD9E54B);
  static const Color background = Color(0xFFF4F7FB);
  static const Color navy = Color(0xFF0B2A52);
  static const Color muted = Color(0xFF6B7C93);
  static const Color soft = Color(0xFFEEF3FA);

  static ThemeData get light {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: court, primary: court),
      scaffoldBackgroundColor: background,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: court, width: 1.6),
        ),
        errorBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.6),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          backgroundColor: court,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
