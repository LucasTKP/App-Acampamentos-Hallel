import 'package:flutter/material.dart';

void showMessage({required BuildContext context, required String message, required Color color}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: color,
    duration: const Duration(milliseconds: 1500),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
