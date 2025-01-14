// message_service.dart
import 'package:flutter/material.dart';

class MessageService {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void showMessage({required String message, required Color color}) {
    if (scaffoldMessengerKey.currentState != null) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(milliseconds: 1500),
      );

      scaffoldMessengerKey.currentState!.hideCurrentSnackBar();
      scaffoldMessengerKey.currentState!.showSnackBar(snackBar);
    }
  }
}