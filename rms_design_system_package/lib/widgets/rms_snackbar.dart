import 'package:flutter/material.dart';
import '../app_colors/neutral_colors.dart';
import '../app_colors/status_colors.dart';

/// Represents the different types of snackbars available in the RMS application.
enum RmsSnackbarType { error, success, info, warning }

/// A utility class for displaying snackbars in the RMS application.
class RmsSnackbar {
  /// Shows a snackbar with the given message and type.
  static void show(
    BuildContext context, {
    required String message,
    RmsSnackbarType type = RmsSnackbarType.error,
  }) {
    final Color color;
    final IconData icon;

    switch (type) {
      case RmsSnackbarType.error:
        color = StatusColors.cancelled;
        icon = Icons.error_outline_rounded;
        break;
      case RmsSnackbarType.success:
        color = StatusColors.ready;
        icon = Icons.check_circle_outline_rounded;
        break;
      case RmsSnackbarType.warning:
        color = StatusColors.pending;
        icon = Icons.warning_amber_rounded;
        break;
      case RmsSnackbarType.info:
        color = StatusColors.preparing;
        icon = Icons.info_outline_rounded;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: NeutralColors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: NeutralColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
