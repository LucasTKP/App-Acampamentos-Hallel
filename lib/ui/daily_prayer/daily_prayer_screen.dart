import 'package:app_acampamentos_hallel/core/models/user_model.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/daily_prayer_controller.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/widgets/dialog_notification_disabled.dart';
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
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF535353),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () async {
                dialogPrayer(context: context, controller: controller, prayer: null);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.prayersToday.length,
          itemBuilder: (context, index) {
            final prayer = controller.prayersToday[index];
            return CardPrayer(prayer: prayer, controller: controller, user: user);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
