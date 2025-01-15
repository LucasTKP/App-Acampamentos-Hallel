import 'package:acamps_canaa/core/models/prayer.dart';
import 'package:acamps_canaa/core/models/user_model.dart';
import 'package:acamps_canaa/ui/daily_prayer/daily_prayer_controller.dart';
import 'package:acamps_canaa/ui/daily_prayer/widgets/dialog_prayer.dart';
import 'package:acamps_canaa/ui/daily_prayer/widgets/dialog_reactions.dart';
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              prayer.userRequest.photoUrl,
                              width: 20,
                              height: 20,
                              errorBuilder: (context, error, stackTrace) => Image.asset(
                                'assets/images/jesus.jpg',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                           Expanded(
                            child: Text(
                              prayer.userRequest.name,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF737373),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            dialogReactions(context: context, prayer: prayer);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color.fromARGB(172, 189, 189, 189),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.remove_red_eye,
                                  size: 12,
                                  color: Colors.black87,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Reações',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        getButtonReaction(),
                      ],
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

  Widget getButtonReaction() {
    final isPrayed = prayer.reactions.any((element) => element.userId == user.id);
    return InkWell(
      onTap: () {
        if (isPrayed) {
          controller.removeReaction(prayer);
        } else {
          controller.addReaction(prayer);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isPrayed ? Colors.blue[200] : Colors.yellow[200],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            const Text(
              "🙏",
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(width: 4),
            Text(
              isPrayed ? "Reagido" : "Reagir",
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget userReaction(UserPrayer reaction) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            reaction.photo,
            width: 20,
            height: 20,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              'assets/images/jesus.jpg',
              width: 20,
              height: 20,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          reaction.name,
          style: const TextStyle(fontSize: 12, color: Color(0xFF737373)),
        ),
      ],
    );
  }
}
