import 'package:app_acampamentos_hallel/core/models/type_liturgy_enum.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/liturgy_controller.dart';
import 'package:flutter/material.dart';

class LiturgyHeader extends StatelessWidget {
  final LiturgyController controller;
  const LiturgyHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (controller.liturgy?.firstLiturgy != null)
            _LiturgyButton(
              text: '1ª Leitura',
              typeLiturgy: TypeLiturgy.primary,
              onTap: () {
                controller.setLiturgySelected(TypeLiturgy.primary);
                controller.pageController.animateToPage(0, duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
              },
              controller: controller,
            ),
          if (controller.liturgy?.firstLiturgy != null) _VerticalDivider(),
          if (controller.liturgy?.psalmLiturgy != null)
            _LiturgyButton(
              text: 'Salmo',
              typeLiturgy: TypeLiturgy.psalm,
              onTap: () {
                controller.setLiturgySelected(TypeLiturgy.psalm);
                controller.pageController.animateToPage(1, duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
              },
              controller: controller,
            ),
          if (controller.liturgy?.psalmLiturgy != null) _VerticalDivider(),
          if (controller.liturgy?.secondLiturgy != null)
            _LiturgyButton(
              text: '2ª Leitura',
              typeLiturgy: TypeLiturgy.secondary,
              onTap: () {
                controller.setLiturgySelected(TypeLiturgy.secondary);
                controller.pageController.animateToPage(2, duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
              },
              controller: controller,
            ),
          if (controller.liturgy?.secondLiturgy != null) _VerticalDivider(),
          if (controller.liturgy?.gospelLiturgy != null)
            _LiturgyButton(
              text: 'Evangelho',
              typeLiturgy: TypeLiturgy.gospel,
              onTap: () {
                controller.setLiturgySelected(TypeLiturgy.gospel);
                controller.pageController.animateToPage(3, duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
              },
              controller: controller,
            ),
        ],
      ),
    );
  }
}

class _LiturgyButton extends StatelessWidget {
  final String text;
  final TypeLiturgy typeLiturgy;
  final VoidCallback onTap;
  final LiturgyController controller;

  const _LiturgyButton({
    required this.text,
    required this.typeLiturgy,
    required this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(controller.backgroundButtonColor(typeLiturgy)),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: controller.textButtonColor(typeLiturgy)),
        ),
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color: const Color.fromARGB(255, 207, 207, 207),
    );
  }
}
