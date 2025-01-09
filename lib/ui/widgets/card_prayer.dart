import 'package:app_acampamentos_hallel/core/models/prayer.dart';
import 'package:app_acampamentos_hallel/core/models/user_model.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/daily_prayer_controller.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/widgets/dialog_prayer.dart';
import 'package:flutter/material.dart';

class CardPrayer extends StatelessWidget {
  final PrayerModel prayer;
  final DailyPrayerController controller;
  final UserModel user;
  const CardPrayer({super.key, required this.prayer, required this.controller, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 228, 228, 228),
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: const BoxConstraints(
            minHeight: 100,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '"${prayer.text}"',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        prayer.userRequest.photoUrl,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      prayer.userRequest.name,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF737373)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (prayer.userRequest.id == user.id)
          Positioned(
            top: 4,
            right: 4,
            child: InkWell(
              onTap: () {
                dialogPrayer(context: context, controller: controller, prayer: prayer);
              },
              child: const Icon(Icons.edit_note_outlined),
            ),
          ),
      ],
    );
  }
}
