import 'package:acamps_canaa/core/extensions/time_stamp_extension.dart';
import 'package:acamps_canaa/core/models/prayer.dart';
import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';

void dialogReactions({required BuildContext context, required PrayerModel prayer}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          height: prayer.reactions.isEmpty ? 200 : MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Reações',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              getReactions(prayer.reactions),
              const SizedBox(height: 8)
            ],
          ),
        ),
      );
    },
  );
}

Widget buildReaction(UserPrayer reaction) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.blue[100],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                reaction.photo,
                width: 35,
                height: 35,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/jesus.jpg',
                  width: 35,
                  height: 35,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                reaction.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF737373),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        Text(
          reaction.createdAt.toDDMMYYYYHHMM(),
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF737373),
          ),
        )
      ],
    ),
  );
}

Widget getReactions(List<UserPrayer> reactions) {
  if (reactions.isEmpty) {
    return const Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info, color: ThemeColors.primaryColor, size: 30),
          SizedBox(height: 4),
          Center(
            child: Text(
              'Ainda não houve reações, \n seja o primeiro a reagir!',
              style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
  return Expanded(
    child: ListView.separated(
      itemCount: reactions.length,
      itemBuilder: (context, index) {
        return buildReaction(reactions[index]);
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 8);
      },
    ),
  );
}
