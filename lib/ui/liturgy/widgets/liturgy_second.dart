import 'package:app_acampamentos_hallel/core/extensions/string_extension.dart';
import 'package:app_acampamentos_hallel/core/models/liturgy_model.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/liturgy_controller.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/widgets/liturgy_hero.dart';
import 'package:flutter/material.dart';

class LiturgySecond extends StatelessWidget {
  final SecondLiturgy secondLiturgy;
  final LiturgyController controller;
  const LiturgySecond({super.key, required this.secondLiturgy, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiturgyHero(controller: controller),
          const SizedBox(height: 16),
          Text("Segunda leitura (${secondLiturgy.reference})", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          const SizedBox(height: 16),
          Text(secondLiturgy.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 18, height: 2, color: Colors.black),
              children: secondLiturgy.text.formatGospelWithBoldNumbers(),
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
