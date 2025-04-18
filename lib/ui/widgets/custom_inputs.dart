import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputs {
  static Widget standard({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required String? Function(String?) validator,
    required IconData? prefixIcon,
    required Widget? suffixIcon,
    String? hintText,
    EdgeInsetsGeometry? contentPadding,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      enabled: enabled,
      keyboardType: keyboardType,
      style: TextStyle(color: enabled ? ThemeColors.primaryColor : Colors.grey, fontWeight: FontWeight.w500),
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: enabled ? ThemeColors.primaryColor : Colors.grey),
        suffixIcon: suffixIcon,
        alignLabelWithHint: true,
        labelText: label,
        hintText: hintText,
        hintStyle: TextStyle(color: enabled ? ThemeColors.primaryColor : Colors.grey),
        filled: true,
        contentPadding: contentPadding,
        fillColor: const Color(0XFFE9E9E9),
        labelStyle: TextStyle(color: enabled ? ThemeColors.primaryColor : Colors.grey),
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
