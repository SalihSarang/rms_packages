import 'package:flutter/material.dart';
import '../app_colors/primary_colors.dart';
import '../app_colors/neutral_colors.dart';

/// A theme class for the RMS application.
class AppTheme {
  /// Returns the dark theme configuration for the application.
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: PrimaryColors.defaultColor,
      scaffoldBackgroundColor: NeutralColors.background,
      colorScheme: const ColorScheme.dark(
        primary: PrimaryColors.defaultColor,
        secondary: PrimaryColors.brandGreen,
        surface: NeutralColors.surface,
        error: Colors.redAccent,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: NeutralColors.background,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: NeutralColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
