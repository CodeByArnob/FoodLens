import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

/// Permanently locked to ThemeMode.dark. User theme switching is disabled.
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((
  ref,
) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark);
}
