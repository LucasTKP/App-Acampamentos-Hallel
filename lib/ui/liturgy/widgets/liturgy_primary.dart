import 'package:acamps_canaa/core/extensions/string_extension.dart';
import 'package:acamps_canaa/core/models/liturgy_model.dart';
import 'package:acamps_canaa/ui/liturgy/liturgy_controller.dart';
import 'package:acamps_canaa/ui/liturgy/widgets/liturgy_hero.dart';
import 'package:flutter/material.dart';

class LiturgyPrimary extends StatelessWidget {
  final FirstLiturgy firstLiturgy;
  final LiturgyController controller;
  const LiturgyPrimary({super.key, required this.firstLiturgy, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiturgyHero(controller: controller),
          const SizedBox(height: 16),
          Text("Primeira leitura (${firstLiturgy.reference})", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          const SizedBox(height: 16),
          Text(firstLiturgy.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 18, height: 2, color: Colors.black),
              children: firstLiturgy.text.formatGospelWithBoldNumbers(),
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          const Text("- Palavra do Senhor.", style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
          const SizedBox(height: 16),
          const Text("- Graças a Deus", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), textAlign: TextAlign.justify),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
