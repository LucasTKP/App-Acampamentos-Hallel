import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputs {
  static Widget standard({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required String? Function(String?) validator,
    required Icon? prefixIcon,
    required Widget? suffixIcon,
    String? hintText,
    EdgeInsetsGeometry? contentPadding,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(color: ThemeColors.primaryColor),
        filled: true,
        contentPadding: contentPadding,
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
}
