import 'package:flutter/material.dart';

class ExameConscience extends StatelessWidget {
  const ExameConscience({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Faça seu exame'),
        ),
        body: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.asset(
            'assets/images/examination_conscience.jpg',
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}