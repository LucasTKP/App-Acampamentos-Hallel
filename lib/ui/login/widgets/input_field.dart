import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';

Widget inputField({
  required TextEditingController controller,
  required String label,
  required bool obscureText,
  required String? Function(String?) validator,
  required IconData? prefixIcon,
    required Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: obscureText,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon, color: ThemeColors.primaryColor, size: 32),
      suffixIcon: suffixIcon,
      labelText:  label,
      filled: true,
      fillColor: const Color(0XFFE9E9E9),
      labelStyle: const TextStyle(color: ThemeColors.primaryColor),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ThemeColors.primaryColor),
        borderRadius: BorderRadius.circular(6),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ThemeColors.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(6),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: ThemeColors.primaryColor),
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}
