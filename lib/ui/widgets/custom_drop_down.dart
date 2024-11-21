import 'package:app_acampamentos_hallel/core/models/dropdown.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class CustomDropDown {
  static Widget standard({
    required List<DropdownModel> items,
    required Function(DropdownModel?) onChanged,
    required String textLabel,
    Icon? icon,
    DropdownModel? value,
    InputDecoration? decoration,
    String? Function(DropdownModel?)? validator,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return DropdownButtonFormField<DropdownModel>(
      value: value,
      onChanged: onChanged,
      hint: Text(textLabel, style: const TextStyle(color: ThemeColors.primaryColor)),
      items: items.map((DropdownModel model) {
        return DropdownMenuItem<DropdownModel>(
          value: model,
          child: Text(model.label),
        );
      }).toList(),
      iconEnabledColor: ThemeColors.primaryColor,
      decoration: InputDecoration(
        
        contentPadding: contentPadding,
        filled: true,
        fillColor: const Color(0XFFE9E9E9),
        labelText: textLabel,
        labelStyle: const TextStyle(color: ThemeColors.primaryColor),
        prefixIcon: icon,
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
