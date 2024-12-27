import 'package:app_acampamentos_hallel/ui/meetings/meetings_controller.dart';
import 'package:app_acampamentos_hallel/ui/meetings/widgets/check_presence_meeting.dart';
import 'package:app_acampamentos_hallel/ui/widgets/card_meeting.dart';
import 'package:flutter/material.dart';

class MeetingsScreen extends StatelessWidget {
  final MeetingsController controller;
  const MeetingsScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text('Reuniões', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
          ExpansionTile(
            shape: Border.all(color: Colors.transparent, width: 0),
            tilePadding: const EdgeInsets.all(0),
            childrenPadding: const EdgeInsets.all(0),
            initiallyExpanded: true,
            visualDensity: VisualDensity.compact,
            title: Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1bbf9b),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 10),
                Text('Abertas (${controller.meetingsOpen.length})', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: List.generate(
                      40,
                      (index) => Expanded(
                        child: Container(
                          height: 1,
                          margin: const EdgeInsets.only(left: 3),
                          color: index % 2 == 0 ? Colors.grey : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final meeting = controller.meetingsOpen[index];
                  return CardMeeting(
                    meeting: meeting,
                    color: const Color(0xFF1bbf9b),
                    checkPresence: (String idMeeting) async {
                      return await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => CheckPresenceMeeting(controller: controller, meetingId: idMeeting),
                      );
                    },
                    buttonCheckPresence: true,
                    verifyPresenceMeeting: controller.getStatusPresenceMeeting,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: controller.meetingsOpen.length,
              ),
            ],
          ),
          ExpansionTile(
            shape: Border.all(color: Colors.transparent, width: 0),
            tilePadding: const EdgeInsets.all(0),
            childrenPadding: const EdgeInsets.all(0),
            initiallyExpanded: false,
            visualDensity: VisualDensity.compact,
            title: Row(
              children: [
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5CAFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 10),
                Text('Fechadas (${controller.meetingsClosed.length})', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    children: List.generate(
                      40,
                      (index) => Expanded(
                        child: Container(
                          height: 1,
                          margin: const EdgeInsets.only(left: 3),
                          color: index % 2 == 0 ? Colors.grey : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final meeting = controller.meetingsClosed[index];
                  return CardMeeting(
                    meeting: meeting,
                    color: const Color(0xFF5CAFFF),
                    buttonCheckPresence: false,
                    verifyPresenceMeeting: controller.getStatusPresenceMeeting,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 5),
                itemCount: controller.meetingsClosed.length,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
