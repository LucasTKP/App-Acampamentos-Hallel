import 'package:acamps_canaa/core/models/liturgy_model.dart';
import 'package:acamps_canaa/ui/liturgy/liturgy_controller.dart';
import 'package:acamps_canaa/ui/liturgy/widgets/liturgy_hero.dart';
import 'package:flutter/material.dart';

class LiturgyPsalm extends StatelessWidget {
  final PsalmLiturgy liturgyPsalm;
  final LiturgyController controller;
  const LiturgyPsalm({super.key, required this.liturgyPsalm, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LiturgyHero(controller: controller),
          const SizedBox(height: 16),
          Text("Salmo Responsório (${liturgyPsalm.reference})", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
          const SizedBox(height: 16),
          Text(liturgyPsalm.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          const SizedBox(height: 8),
          Text(liturgyPsalm.text, style: const TextStyle(fontSize: 16, height: 2), textAlign: TextAlign.justify),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
