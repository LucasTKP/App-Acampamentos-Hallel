import 'package:acamps_canaa/core/models/type_liturgy_enum.dart';
import 'package:acamps_canaa/ui/liturgy/liturgy_controller.dart';
import 'package:flutter/material.dart';

class LiturgyHeader extends StatelessWidget {
  final LiturgyController controller;
  const LiturgyHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    const Map<String, int> textWeights = {
      '1ª Leitura': 3,
      'Salmo': 2,
      '2ª Leitura': 3,
      'Evangelho': 3,
    };

    return Container(
      color: const Color.fromARGB(255, 222, 228, 219),
      child: Row(
        children: [
          if (controller.liturgy?.firstLiturgy != null) ...[
            Flexible(
              flex: textWeights['1ª Leitura']!,
              child: _LiturgyButton(
                text: '1ª Leitura',
                typeLiturgy: TypeLiturgy.primary,
                onTap: () {
                  controller.setLiturgySelected(TypeLiturgy.primary);
                  controller.pageController.animateToPage(0, duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
                },
                controller: controller,
              ),
            ),
            _VerticalDivider(),
          ],
          if (controller.liturgy?.psalmLiturgy != null) ...[
            Flexible(
              flex: textWeights['Salmo']!,
              child: _LiturgyButton(
                text: 'Salmo',
                typeLiturgy: TypeLiturgy.psalm,
                onTap: () {
                  controller.setLiturgySelected(TypeLiturgy.psalm);
                  controller.pageController.animateToPage(1, duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
                },
                controller: controller,
              ),
            ),
            _VerticalDivider(),
          ],
          if (controller.liturgy?.secondLiturgy != null) ...[
            Flexible(
              flex: textWeights['2ª Leitura']!,
              child: _LiturgyButton(
                text: '2ª Leitura',
                typeLiturgy: TypeLiturgy.secondary,
                onTap: () {
                  controller.setLiturgySelected(TypeLiturgy.secondary);
                  controller.pageController.animateToPage(2, duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
                },
                controller: controller,
              ),
            ),
            _VerticalDivider(),
          ],
          if (controller.liturgy?.gospelLiturgy != null)
            Flexible(
              flex: textWeights['Evangelho']!,
              child: _LiturgyButton(
                text: 'Evangelho',
                typeLiturgy: TypeLiturgy.gospel,
                onTap: () {
                  controller.setLiturgySelected(TypeLiturgy.gospel);
                  controller.pageController.animateToPage(3, duration: const Duration(milliseconds: 10), curve: Curves.easeInOut);
                },
                controller: controller,
              ),
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
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(controller.backgroundButtonColor(typeLiturgy)),
          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 0, vertical: 18)),
          visualDensity: VisualDensity.compact,
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: controller.textButtonColor(typeLiturgy),
          ),
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
