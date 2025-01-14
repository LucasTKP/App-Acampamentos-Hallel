import 'package:app_acampamentos_hallel/core/extensions/string_extension.dart';
import 'package:app_acampamentos_hallel/core/models/liturgy_model.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/liturgy_controller.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/widgets/liturgy_hero.dart';
import 'package:flutter/material.dart';

class LiturgyGospel extends StatelessWidget {
  final GospelLiturgy gospelLiturgy;
  final LiturgyController controller;
  const LiturgyGospel({super.key, required this.gospelLiturgy, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiturgyHero(controller: controller),
          const SizedBox(height: 16),
          Text("Evangelho (${gospelLiturgy.reference})", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          const SizedBox(height: 16),
          Text(gospelLiturgy.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(height: 16),
          const Text("- Gloria a vós, Senhor.", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18)),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 18, height: 2, color: Colors.black),
              children: gospelLiturgy.text.formatGospelWithBoldNumbers(),
            ),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          const Text("- Palavra da Salvação.", style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
          const SizedBox(height: 16),
          const Text("- Glória a vós, Senhor", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), textAlign: TextAlign.justify),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
