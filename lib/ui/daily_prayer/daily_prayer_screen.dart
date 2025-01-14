import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/models/user_model.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/daily_prayer_controller.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/widgets/daily_prayer_skeleton.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/widgets/dialog_prayer.dart';
import 'package:app_acampamentos_hallel/ui/widgets/card_prayer.dart';
import 'package:flutter/material.dart';

class DailyPrayerScreen extends StatelessWidget {
  final DailyPrayerController controller;
  final UserModel user;
  const DailyPrayerScreen({super.key, required this.controller, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Orações Diárias',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF535353),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () async {
                    dialogPrayer(context: context, controller: controller, prayer: null);
                  },
                  child: const Icon(Icons.add, color: Color(0xFF535353)),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () async {
                    controller.getDailyPrayers();
                  },
                  child: const Icon(Icons.refresh, color: Color(0xFF535353)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.setTodayIsSelected(false);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: !controller.todayIsSelected ? ThemeColors.primaryColor : ThemeColors.primaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                  ),
                  child: Text(
                    'Ontem',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: !controller.todayIsSelected ? FontWeight.w500 : FontWeight.w400,
                      color: !controller.todayIsSelected ? Colors.black87 : Colors.black12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.setTodayIsSelected(true);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: controller.todayIsSelected ? ThemeColors.primaryColor : ThemeColors.primaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: Text(
                    'Hoje',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: controller.todayIsSelected ? FontWeight.w500 : FontWeight.w400,
                      color: controller.todayIsSelected ? Colors.black87 : Colors.black12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        prayers(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget prayers() {
    if (controller.state == AsyncState.loading) {
      return Column(
        children: List.generate(4, (index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: DailyPrayerSkeleton(),
          );
        }),
      );
    }

    if (controller.todayIsSelected == true) {
      if (controller.prayersToday.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 228, 228, 228),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            children: [
              Icon(Icons.info, color: ThemeColors.primaryColor),
              SizedBox(height: 8),
              Text(
                'Não encontramos nenhuma solicitação de oração.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      } else {
        return ListView.separated(
          itemCount: controller.prayersToday.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, listIndex) {
            final prayer = controller.prayersToday[listIndex];
            return CardPrayer(
              prayer: prayer,
              controller: controller,
              user: user,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        );
      }
    } else {
      if (controller.prayersYesterday.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 228, 228, 228),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Column(
            children: [
              Icon(Icons.info, color: ThemeColors.primaryColor),
              SizedBox(height: 8),
              Text(
                'Não encontramos nenhuma solicitação de oração.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      } else {
        return ListView.separated(
          itemCount: controller.prayersYesterday.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, listIndex) {
            final prayer = controller.prayersYesterday[listIndex];
            return CardPrayer(
              prayer: prayer,
              controller: controller,
              user: user,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        );
      }
    }
  }
}
