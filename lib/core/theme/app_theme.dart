import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static TextStyle _fontStyle({
    required String language,
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    if (language == 'bn') {
      return GoogleFonts.hindSiliguri(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height != null ? height * 1.05 : 1.35,
      );
    } else if (language == 'ar') {
      return GoogleFonts.cairo(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );
    }
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextTheme _buildTextTheme({
    required String language,
    required bool isDark,
  }) {
    final primaryColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final secondaryColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return TextTheme(
      displayLarge: _fontStyle(
        language: language,
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: primaryColor,
        letterSpacing: -0.5,
      ),
      displayMedium: _fontStyle(
        language: language,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        letterSpacing: -0.4,
      ),
      headlineMedium: _fontStyle(
        language: language,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: primaryColor,
      ),
      titleLarge: _fontStyle(
        language: language,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      titleMedium: _fontStyle(
        language: language,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      bodyLarge: _fontStyle(
        language: language,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
        height: 1.5,
      ),
      bodyMedium: _fontStyle(
        language: language,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
      ),
      labelLarge: _fontStyle(
        language: language,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
    );
  }

  static ThemeData getDarkTheme({String language = 'en'}) {
    final textTheme = _buildTextTheme(language: language, isDark: true);
    final fontFam = language == 'bn'
        ? GoogleFonts.hindSiliguri().fontFamily
        : (language == 'ar'
              ? GoogleFonts.cairo().fontFamily
              : GoogleFonts.plusJakartaSans().fontFamily);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: Color(0xFF064E3B),
        onPrimaryContainer: AppColors.primaryAccent,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFF1E3A8A),
        onSecondaryContainer: AppColors.secondaryLight,
        surface: AppColors.darkSurface,
        onSurface: AppColors.textPrimaryDark,
        error: AppColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      fontFamily: fontFam,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        titleTextStyle: _fontStyle(
          language: language,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryDark,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurfaceCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMutedDark,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData getLightTheme({String language = 'en'}) {
    final textTheme = _buildTextTheme(language: language, isDark: false);
    final fontFam = language == 'bn'
        ? GoogleFonts.hindSiliguri().fontFamily
        : (language == 'ar'
              ? GoogleFonts.cairo().fontFamily
              : GoogleFonts.plusJakartaSans().fontFamily);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: Color(0xFFD1FAE5),
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: Color(0xFFDBEAFE),
        onSecondaryContainer: AppColors.secondaryDark,
        surface: AppColors.lightSurface,
        onSurface: AppColors.textPrimaryLight,
        error: AppColors.error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      fontFamily: fontFam,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        titleTextStyle: _fontStyle(
          language: language,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimaryLight,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primaryDark,
        unselectedItemColor: AppColors.textMutedLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData get darkTheme => getDarkTheme();
  static ThemeData get lightTheme => getLightTheme();
}
