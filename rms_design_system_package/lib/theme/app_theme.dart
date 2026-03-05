import 'package:flutter/material.dart';
import '../app_colors/primary_colors.dart';
import '../app_colors/neutral_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: PrimaryColors.defaultColor,
      scaffoldBackgroundColor: NeutralColors.background,
      colorScheme: const ColorScheme.dark(
        primary: PrimaryColors.defaultColor,
        secondary: PrimaryColors.brandGreen,
        surface: NeutralColors.surface,
        background: NeutralColors.background,
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
