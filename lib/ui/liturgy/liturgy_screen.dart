import 'package:app_acampamentos_hallel/core/models/type_liturgy_enum.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/liturgy_controller.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/widgets/liturgy_gospel.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/widgets/liturgy_header.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/widgets/liturgy_psalm.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/widgets/liturgy_primary.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/widgets/liturgy_second.dart';
import 'package:flutter/material.dart';

class LiturgyScreen extends StatelessWidget {
  final LiturgyController controller;

  const LiturgyScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LiturgyHeader(controller: controller),
        Expanded(
          child: PageView(
            controller: controller.pageController,
            padEnds: true,
            pageSnapping: true,
            onPageChanged: (index) {
              if (index == 2 && controller.liturgy?.secondLiturgy == null) {
                index++;
              }
              controller.setLiturgySelected(TypeLiturgy.values[index]);
            },
            children: [
              if (controller.liturgy?.firstLiturgy != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LiturgyPrimary(firstLiturgy: controller.liturgy!.firstLiturgy!, controller: controller),
                ),
              if (controller.liturgy?.psalmLiturgy != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LiturgyPsalm(liturgyPsalm: controller.liturgy!.psalmLiturgy!, controller: controller),
                ),
              if (controller.liturgy?.secondLiturgy != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LiturgySecond(secondLiturgy: controller.liturgy!.secondLiturgy!, controller: controller),
                ),
              if (controller.liturgy?.gospelLiturgy != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LiturgyGospel(gospelLiturgy: controller.liturgy!.gospelLiturgy!, controller: controller),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
