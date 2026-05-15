import 'package:flutter/material.dart';
import '../app_colors/neutral_colors.dart';
import '../app_colors/primary_colors.dart';
import '../app_colors/text_colors.dart';

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

  /// The background color of the button.
  final Color? backgroundColor;

  /// A custom child widget to display inside the button.
  /// If provided, this replaces the default text and icon layout.
  final Widget? child;

  /// The height of the button.
  final double? height;

  const RmsButton({
    super.key,
    this.text = '',
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isOutlined = false,
    this.textColor,
    this.borderColor,
    this.backgroundColor,
    this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = borderColor ?? PrimaryColors.defaultColor;
    final fillColor = backgroundColor ?? activeColor;
    final contentColor =
        textColor ?? (isOutlined ? activeColor : TextColors.primary);

    final verticalPadding = height != null ? 0.0 : 16.0;

    return SizedBox(
      width: double.infinity,
      height: height,
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
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
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
                backgroundColor: (onPressed == null || isLoading)
                    ? fillColor.withValues(alpha: 0.3)
                    : fillColor,
                foregroundColor: contentColor,
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: borderColor != null
                      ? BorderSide(color: borderColor!)
                      : BorderSide.none,
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

    if (child != null) return child!;

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
