import 'package:app_acampamentos_hallel/core/extensions/date_time_extension.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/liturgy_controller.dart';
import 'package:flutter/material.dart';

class LiturgyHero extends StatelessWidget {
  final LiturgyController controller;
  const LiturgyHero({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: controller.dateSelected,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
                locale: const Locale('pt', 'BR'),
                builder: (context, child) => Theme(
                  data: ThemeData.light().copyWith(
                    colorScheme: const ColorScheme.light().copyWith(primary: ThemeColors.primaryColor),
                  ),
                  child: child!,
                ),
              );
              if (picked != null && picked != controller.dateSelected) {
                controller.setDateSelected(picked);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.dateSelected.day.toString(),
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500, color: Colors.grey[800]),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.dateSelected.abbreviatedMonth(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey[800])),
                    Text(
                      controller.dateSelected.year.toString(),
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey[800]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.turned_in,
                size: 20,
                color: controller.getColorLiturgy(),
                shadows: const [BoxShadow(color: Colors.black, blurRadius: 1, offset: Offset(0, 0))],
              ),
              const SizedBox(width: 5),
              Text(
                'Cor Litúrgica: ${controller.liturgy?.color}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey[800]),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(controller.liturgy?.liturgy ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey[800]), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
