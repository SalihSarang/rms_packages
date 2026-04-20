import 'package:flutter/material.dart';
import '../app_colors/text_colors.dart';

/// [RmsAppBarTitle] is the standardized title widget for all AppBars across the RMS portals.
///
/// It enforces a consistent typography (fontSize 18, Semi-Bold) and color (TextColors.primary).
class RmsAppBarTitle extends StatelessWidget {
  final String text;

  const RmsAppBarTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: TextColors.primary,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
