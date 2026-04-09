import 'package:flutter/material.dart';
import '../app_colors/neutral_colors.dart';
import '../app_colors/primary_colors.dart';
import '../app_colors/status_colors.dart';
import '../app_colors/text_colors.dart';
import 'rms_button.dart';

/// Defines the type/intent of the [RmsAlertDialog].
///
/// Each type provides a default accent color and icon that matches the
/// RMS design system color palette.
enum RmsAlertDialogType {
  /// An informational dialog (blue accent).
  info,

  /// A success dialog (green accent).
  success,

  /// A warning dialog (amber accent).
  warning,

  /// An error or destructive action dialog (red accent).
  error,

  /// A general confirmation dialog (primary blue accent).
  confirm,
}

/// A utility class for displaying customizable alert dialogs in the RMS application.
///
/// All colors are sourced exclusively from the RMS design system color palette.
/// The dialog is fully responsive and adapts to both mobile and web screen sizes.
///
/// ### Basic Usage
/// ```dart
/// RmsAlertDialog.show(
///   context,
///   title: 'Delete Order',
///   message: 'Are you sure you want to delete this order?',
///   type: RmsAlertDialogType.error,
///   confirmText: 'Delete',
///   onConfirm: () { /* delete logic */ },
/// );
/// ```
class RmsAlertDialog {
  const RmsAlertDialog._();

  /// Shows an [RmsAlertDialog] with the given configuration.
  ///
  /// - [title]: The heading text displayed at the top of the dialog.
  /// - [message]: The body message text.
  /// - [type]: Drives the default icon and accent color. Defaults to [RmsAlertDialogType.confirm].
  /// - [confirmText]: Label for the primary/confirm button. Defaults to `'Confirm'`.
  /// - [cancelText]: Label for the secondary/cancel button. Defaults to `'Cancel'`.
  /// - [onConfirm]: Called when the confirm button is tapped. Dialog auto-closes after.
  /// - [onCancel]: Called when the cancel button is tapped. Dialog auto-closes after.
  /// - [accentColor]: Overrides the type's default accent color.
  /// - [icon]: Overrides the type's default icon.
  /// - [showCancelButton]: Whether to show the cancel button. Defaults to `true`.
  /// - [barrierDismissible]: Whether tapping outside the dialog closes it. Defaults to `true`.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    RmsAlertDialogType type = RmsAlertDialogType.confirm,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Color? accentColor,
    IconData? icon,
    bool showCancelButton = true,
    bool barrierDismissible = true,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: NeutralColors.blackAlpha40,
      builder: (_) => _RmsAlertDialogContent(
        title: title,
        message: message,
        type: type,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        accentColor: accentColor,
        icon: icon,
        showCancelButton: showCancelButton,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Internal widget — not part of the public API
// ---------------------------------------------------------------------------

class _RmsAlertDialogContent extends StatelessWidget {
  const _RmsAlertDialogContent({
    required this.title,
    required this.message,
    required this.type,
    required this.confirmText,
    required this.cancelText,
    required this.showCancelButton,
    this.onConfirm,
    this.onCancel,
    this.accentColor,
    this.icon,
  });

  final String title;
  final String message;
  final RmsAlertDialogType type;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Color? accentColor;
  final IconData? icon;
  final bool showCancelButton;

  // ---- Resolve defaults from type ----------------------------------------

  Color _resolvedAccent() {
    if (accentColor != null) return accentColor!;
    switch (type) {
      case RmsAlertDialogType.info:
        return StatusColors.preparing;
      case RmsAlertDialogType.success:
        return StatusColors.ready;
      case RmsAlertDialogType.warning:
        return StatusColors.pending;
      case RmsAlertDialogType.error:
        return StatusColors.cancelled;
      case RmsAlertDialogType.confirm:
        return PrimaryColors.defaultColor;
    }
  }

  IconData _resolvedIcon() {
    if (icon != null) return icon!;
    switch (type) {
      case RmsAlertDialogType.info:
        return Icons.info_outline_rounded;
      case RmsAlertDialogType.success:
        return Icons.check_circle_outline_rounded;
      case RmsAlertDialogType.warning:
        return Icons.warning_amber_rounded;
      case RmsAlertDialogType.error:
        return Icons.error_outline_rounded;
      case RmsAlertDialogType.confirm:
        return Icons.help_outline_rounded;
    }
  }

  // ---- Build -------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final accent = _resolvedAccent();
    final resolvedIcon = _resolvedIcon();
    final screenWidth = MediaQuery.sizeOf(context).width;

    // Responsive width: 90% on mobile, capped at 480 on wider screens
    final dialogWidth = screenWidth < 600
        ? screenWidth * 0.9
        : 480.0;

    return Dialog(
      backgroundColor: NeutralColors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Center(
        child: SizedBox(
          width: dialogWidth,
          child: _buildCard(context, accent, resolvedIcon),
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    Color accent,
    IconData resolvedIcon,
  ) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: NeutralColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: NeutralColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: NeutralColors.shadow.withValues(alpha: 0.4),
            blurRadius: 32,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIconBadge(accent, resolvedIcon),
          const SizedBox(height: 20),
          _buildTitle(),
          const SizedBox(height: 10),
          _buildMessage(),
          const SizedBox(height: 28),
          _buildActions(context, accent),
        ],
      ),
    );
  }

  Widget _buildIconBadge(Color accent, IconData resolvedIcon) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(
          color: accent.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Icon(
        resolvedIcon,
        color: accent,
        size: 30,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: NeutralColors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    );
  }

  Widget _buildMessage() {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: TextColors.secondary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
    );
  }

  Widget _buildActions(BuildContext context, Color accent) {
    return Column(
      children: [
        // Confirm button — filled with accent color
        RmsButton(
          text: confirmText,
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm?.call();
          },
          borderColor: accent,
        ),
        if (showCancelButton) ...[
          const SizedBox(height: 12),
          // Cancel button — outlined with accent border
          RmsButton(
            text: cancelText,
            isOutlined: true,
            borderColor: accent,
            onPressed: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
          ),
        ],
      ],
    );
  }
}
