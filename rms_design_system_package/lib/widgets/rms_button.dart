import 'package:flutter/material.dart';
import '../app_colors/neutral_colors.dart';
import '../app_colors/primary_colors.dart';

/// A customizable button widget for the RMS application.
///
/// Provides both filled and outlined button styles with loading and disabled states.
class RmsButton extends StatelessWidget {
  /// The text to display on the button.
  final String text;

  /// The callback function to execute when the button is pressed.
  final VoidCallback? onPressed;

  /// Whether the button should display a loading indicator.
  final bool isLoading;

  /// An optional icon to display on the button.
  final Widget? icon;

  /// Whether the button should be displayed in outlined style.
  final bool isOutlined;

  /// The color of the text.
  final Color? textColor;

  /// The color of the border.
  final Color? borderColor;

  const RmsButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isOutlined = false,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = borderColor ?? PrimaryColors.defaultColor;
    final contentColor =
        textColor ?? (isOutlined ? activeColor : NeutralColors.white);

    return SizedBox(
      width: double.infinity,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: (onPressed == null || isLoading)
                      ? activeColor.withValues(alpha: 0.3)
                      : activeColor,
                ),
                foregroundColor: (onPressed == null || isLoading)
                    ? contentColor.withValues(alpha: 0.3)
                    : contentColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: _buildContent(contentColor),
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: activeColor,
                foregroundColor: contentColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
                shadowColor: NeutralColors.transparent,
              ),
              child: _buildContent(contentColor),
            ),
    );
  }

  Widget _buildContent(Color contentColor) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2, color: contentColor),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[icon!, const SizedBox(width: 8)],
        Text(
          text,
          style: TextStyle(
            color: contentColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
