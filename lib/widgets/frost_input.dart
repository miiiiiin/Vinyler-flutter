import 'package:flutter/material.dart';
import '../theme/frost_theme.dart';

/// Frost 입력 필드 (label + glass input). focus 시 accent 보더 + 글로우 링.
class FrostInput extends StatelessWidget {
  const FrostInput({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.autofocus = false,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: FrostColors.textMuted)),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          autofocus: autofocus,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 15, color: FrostColors.text),
          cursorColor: FrostColors.accent,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: const TextStyle(color: FrostColors.textFaint),
            filled: true,
            fillColor: const Color(0x0DFFFFFF), // rgba(255,255,255,0.05)
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: FrostColors.borderFaint),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0x8C9D90E8), width: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}
