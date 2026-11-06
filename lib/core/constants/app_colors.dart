import 'package:flutter/material.dart';

class AppColors {
  // Brand Palette - Premium SaaS Emerald / Mint & Deep Obsidian
  static const Color primary = Color(0xFF10B981); // Emerald Green
  static const Color primaryLight = Color(0xFF34D399);
  static const Color primaryDark = Color(0xFF059669);
  static const Color primaryAccent = Color(0xFF6EE7B7);

  static const Color secondary = Color(0xFF3B82F6); // Electric Sapphire
  static const Color secondaryLight = Color(0xFF60A5FA);
  static const Color secondaryDark = Color(0xFF2563EB);

  static const Color tertiary = Color(0xFFF59E0B); // Amber / Gold
  static const Color accentRose = Color(0xFFF43F5E); // Ruby / Warning
  static const Color accentPurple = Color(0xFF8B5CF6); // Violet

  // Macronutrient Colors
  static const Color protein = Color(0xFFEF4444); // Red/Coral
  static const Color carbs = Color(0xFF3B82F6); // Blue
  static const Color fat = Color(0xFFF59E0B); // Amber/Yellow
  static const Color fiber = Color(0xFF10B981); // Emerald
  static const Color calories = Color(0xFFFF6B6B);

  // Background & Surface - Dark Mode (Default Premium SaaS Dark)
  static const Color darkBackground = Color(0xFF090D16);
  static const Color darkSurface = Color(0xFF111827);
  static const Color darkSurfaceCard = Color(0xFF1E293B);
  static const Color darkSurfaceHighlight = Color(0xFF334155);
  static const Color darkBorder = Color(0xFF1E293B);
  static const Color darkGlassBorder = Color(0x3394A3B8);

  // Background & Surface - Light Mode
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceCard = Color(0xFFF1F5F9);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightGlassBorder = Color(0x3364748B);

  // Neutral Text
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textMutedLight = Color(0xFF94A3B8);

  // Status & Badges
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF0EA5E9);

  // Puter Brand
  static const Color puterBlue = Color(0xFF0055FF);
  static const Color puterGlow = Color(0x400055FF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF0EA5E9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient scannerLaserGradient = LinearGradient(
    colors: [
      Colors.transparent,
      Color(0x3310B981),
      Color(0xFF10B981),
      Color(0x3310B981),
      Colors.transparent,
    ],
    stops: [0.0, 0.2, 0.5, 0.8, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF161F30), Color(0xFF0F172A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
