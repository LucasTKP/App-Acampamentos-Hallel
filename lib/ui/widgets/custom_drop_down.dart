import 'package:acamps_canaa/core/models/dropdown.dart';
import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class CustomDropDown {
  static Widget standard({
    required List<DropdownModel> items,
    required Function(DropdownModel?) onChanged,
    required String textLabel,
    IconData? icon,
    DropdownModel? value,
    InputDecoration? decoration,
    String? Function(DropdownModel?)? validator,
    EdgeInsetsGeometry? contentPadding,
    bool enabled = true,
  }) {
    return DropdownButtonFormField<DropdownModel>(
      value: value,
      menuMaxHeight: 200,
      onChanged: enabled ? onChanged : null,
      hint: Text(textLabel, style: const TextStyle(color: ThemeColors.primaryColor)),
      items: items.map((DropdownModel model) {
        return DropdownMenuItem<DropdownModel>(
          value: model,
          child: Text(
            model.label,
            style: TextStyle(
              color: enabled ? ThemeColors.primaryColor : Colors.grey,
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        prefixIconColor: enabled ? ThemeColors.primaryColor : Colors.grey,
        contentPadding: contentPadding,
        filled: true,
        fillColor: const Color(0XFFE9E9E9),
        labelText: textLabel,
        labelStyle: TextStyle(color: enabled ? ThemeColors.primaryColor : Colors.grey),
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabled ? ThemeColors.primaryColor : Colors.grey),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: enabled ? ThemeColors.primaryColor : Colors.grey),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      icon: Icon(
        Icons.arrow_drop_down, 
        color: enabled ? ThemeColors.primaryColor : Colors.grey,
      ),
    );
  }
}
