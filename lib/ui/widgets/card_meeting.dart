import 'package:app_acampamentos_hallel/core/extensions/date_time_extension.dart';
import 'package:app_acampamentos_hallel/core/models/meeting_model.dart';
import 'package:flutter/material.dart';

class CardMeeting extends StatelessWidget {
  final MeetingModel meeting;
  final Color color;
  const CardMeeting({super.key, required this.meeting, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(meeting.date.abbreviatedMonth(), style: TextStyle(fontSize: 16, color: color)),
            Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(meeting.date.day.toString(), style: const TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                Container(
                  height: 1,
                  width: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(meeting.date.year.toString(), style: const TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 25,
              child: Center(
                child: Container(
                  height: 60,
                  width: 3,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Card(
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(10),
              height: 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(meeting.date.toDDMMYYYY(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text(meeting.theme, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16)),
                  Text(meeting.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
