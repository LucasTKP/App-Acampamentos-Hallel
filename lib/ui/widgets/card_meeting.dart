import 'package:app_acampamentos_hallel/core/extensions/date_time_extension.dart';
import 'package:app_acampamentos_hallel/core/models/meeting_model.dart';
import 'package:app_acampamentos_hallel/core/models/status_presence_meeting.dart';
import 'package:flutter/material.dart';

class CardMeeting extends StatelessWidget {
  final MeetingModel meeting;
  final Color color;
  final Function? checkPresence;
  final bool buttonCheckPresence;
  final Function verifyPresenceMeeting;
  const CardMeeting({
    super.key,
    required this.meeting,
    required this.color,
    this.checkPresence,
    required this.buttonCheckPresence,
    required this.verifyPresenceMeeting,
  });

  @override
  Widget build(BuildContext context) {
    final status = verifyPresenceMeeting(meeting);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
              Expanded(
                child: SizedBox(
                  width: 25,
                  child: Center(
                    child: Container(
                      width: 3,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(25),
                      ),
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
                constraints: const BoxConstraints(minHeight: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(meeting.date.toDDMMYYYY(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87)),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: getColorStatus(status), width: 1),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          child: Text(
                            getTextStatus(status),
                            style: TextStyle(fontSize: 12, color: getColorStatus(status), fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text("Tema: ${meeting.theme}", maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                    Text("Descrição: ${meeting.description}", maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black54)),
                    if (status == StatusPresenceMeeting.open)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: checkPresence != null && status == StatusPresenceMeeting.open ? () => checkPresence!(meeting.id) : null,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            visualDensity: VisualDensity.compact,
                            backgroundColor: color,
                          ),
                          child: const Text(
                            "Marcar Presença",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getTextStatus(StatusPresenceMeeting status) {
    switch (status) {
      case StatusPresenceMeeting.open:
        return 'Em Aberto';
      case StatusPresenceMeeting.checked:
        return 'Registrado';
      default:
        return 'Você Faltou';
    }
  }

  Color getColorStatus(StatusPresenceMeeting status) {
    switch (status) {
      case StatusPresenceMeeting.open:
        return const Color(0xFF1bbf9b);
      case StatusPresenceMeeting.checked:
        return const Color(0xFF5CAFFF);
      default:
        return const Color.fromARGB(255, 187, 18, 18);
    }
  }
}
