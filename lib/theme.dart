import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF6C91BF);
  static const Color accent = Color(0xFFC4D7ED);
  static const Color background = Color(0xFFF5F8FA);
  static const Color text = Color(0xFF2B3E5D);
  static const Color neutral = Color(0xFF8FA5BF);

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: background,
    primaryColor: primary,
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: accent,
      background: background,
      onPrimary: Colors.white,
      onSecondary: text,
      onBackground: text,
      surface: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(color: text, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: text),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: accent.withOpacity(0.2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: neutral),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
