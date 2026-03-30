import 'dart:ui';

/// Colors specific to the Table Management features.
class TableColors {
  /// Accent color for rectangular tables and sections.
  static const Color rectangular = Color(0xFF7C5CFC);

  /// Accent color for round tables and sections.
  static const Color round = Color(0xFF5CE0E6);
  
  /// A soft, premium red for destructive actions.
  static const Color destructive = Color(0xFFE47C7C);

  // ─── Status Colors ───────────────────────────────────────────

  // Occupied
  static const Color occupiedFill = Color(0xFF3D1A1A);
  static const Color occupiedGradientStart = Color(0xFF4A1F1F);
  static const Color occupiedText = Color(0xFFFF8A80);

  // Reserved
  static const Color reservedFill = Color(0xFF1A2A3D);
  static const Color reservedGradientStart = Color(0xFF1F2E4A);
  static const Color reservedText = Color(0xFF90CAF9);

  // Bill Requested
  static const Color billRequestedFill = Color(0xFF3D2E10);
  static const Color billRequestedGradientStart = Color(0xFF4A381A);
  static const Color billRequestedText = Color(0xFFFFCC80);

  // Cleaning
  static const Color cleaningFill = Color(0xFF1A3D2A);
  static const Color cleaningText = Color(0xFFA5D6A7);
}
