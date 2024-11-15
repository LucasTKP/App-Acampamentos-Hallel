import 'package:app_acampamentos_hallel/ui/welcome/welcome_controller.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeController controller;
  const WelcomeScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Image(
        image: AssetImage('assets/logos/canaa/canaa.png'),
      ),
    );
  }
}
