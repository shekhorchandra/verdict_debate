import 'package:flutter/material.dart';

import '../values/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData? icon;
  final bool obscure;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final int? maxLength;
  final int? maxLines;
  final String? errorText;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.hint,
    this.icon,
    this.obscure = false,
    this.suffix,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLength,
    this.maxLines,
    this.errorText,
    this.focusNode,
    this.validator,
    this.readOnly = false,
    required TextStyle hintStyle,
    required TextStyle textStyle, // default false
  });

  @override
  Widget build(BuildContext context) {
    final safeMaxLines = obscure ? 1 : (maxLines ?? 1);
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscure,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: safeMaxLines,
      validator: validator,

      style: const TextStyle(
        color: Colors.white, // ✅ input text color
      ),

      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white54, // ✅ hint color
        ),

        errorStyle: const TextStyle(
          color: Colors.redAccent, // optional better visibility
        ),

        prefixIcon: icon != null
            ? Icon(icon, color: Colors.white70)
            : null,

        suffixIcon: suffix,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),

        filled: true,
        fillColor: const Color(0xFF1E1B4B), // ✅ dark background (important)

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColor.primary, width: 1),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.white24),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColor.primary, width: 1.5),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
