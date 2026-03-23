import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary     = Color(0xFF00B4A0);
  static const primaryDark = Color(0xFF007A6E);
  static const secondary   = Color(0xFF6C63FF);
  static const accent      = Color(0xFFFF6B6B);
  static const bg          = Color(0xFFF5F7FA);
  static const card        = Colors.white;
  static const dark        = Color(0xFF0D1B2A);
  static const textPrimary   = Color(0xFF1A2332);
  static const textSecondary = Color(0xFF6B7A8D);
  static const textLight     = Color(0xFFB0BEC5);
  static const gradientStart = Color(0xFF00B4A0);
  static const gradientEnd   = Color(0xFF6C63FF);
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFF9800);
  static const error   = Color(0xFFFF6B6B);
}

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.cairo().fontFamily,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: GoogleFonts.cairo(
        fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
      ),
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: GoogleFonts.cairo(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE8ECF0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      hintStyle: GoogleFonts.cairo(color: AppColors.textLight, fontSize: 14),
      labelStyle: GoogleFonts.cairo(color: AppColors.textSecondary),
    ),
  );
}
