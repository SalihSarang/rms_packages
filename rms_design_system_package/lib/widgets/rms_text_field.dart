import 'package:flutter/material.dart';
import '../app_colors/neutral_colors.dart';
import '../app_colors/primary_colors.dart';
import '../app_colors/text_colors.dart';

/// A customizable text field widget for the RMS application.
///
/// Provides a standard text input with label, hint text, validation, and optional suffix icon.
class RmsTextField extends StatelessWidget {
  /// The label displayed above the text field.
  final String label;

  /// The hint text displayed inside the text field when empty.
  final String hintText;

  /// Whether the text field should obscure input (for passwords).
  final bool obscureText;

  /// The controller for managing the text field's content.
  final TextEditingController? controller;

  /// Callback function called when the text field's value changes.
  final ValueChanged<String>? onChanged;

  /// Optional suffix icon to display at the end of the text field.
  final Widget? suffixIcon;

  /// Optional widget to display next to the label.
  final Widget? labelSuffix;

  /// Optional validator function to validate the text field's input.
  final String? Function(String?)? validator;

  const RmsTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.labelSuffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: TextColors.secondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            ?labelSuffix,
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          validator: validator,
          style: const TextStyle(color: TextColors.primary),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: TextColors.secondary.withValues(alpha: 0.5),
            ),
            filled: true,
            fillColor: NeutralColors.background,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: NeutralColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: NeutralColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: PrimaryColors.defaultColor),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
