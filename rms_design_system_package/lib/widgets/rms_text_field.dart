import 'package:flutter/material.dart';
import '../app_colors/neutral_colors.dart';
import '../app_colors/primary_colors.dart';
import '../app_colors/text_colors.dart';

class RmsTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final Widget? labelSuffix;
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
          style: const TextStyle(color: TextColors.inverse),
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
