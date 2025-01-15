import 'package:acamps_canaa/core/extensions/date_time_extension.dart';
import 'package:acamps_canaa/ui/meetings/meetings_controller.dart';
import 'package:acamps_canaa/ui/widgets/custom_button.dart';
import 'package:acamps_canaa/ui/widgets/custom_inputs.dart';
import 'package:flutter/material.dart';

class CheckPresenceMeeting extends StatelessWidget {
  final MeetingsController controller;
  final String meetingId;
  const CheckPresenceMeeting({super.key, required this.controller, required this.meetingId});

  @override
  Widget build(BuildContext context) {
    final meeting = controller.meetingsOpen.firstWhere((element) => element.id == meetingId);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, index) {
        return Form(
          key: controller.formKey,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            insetPadding: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reunião do dia ${meeting.date.toDDMMYYYY()}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Tema: ${meeting.theme}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  Text('Descrição: ${meeting.description}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  CustomInputs.standard(
                    controller: controller.passwordController,
                    label: 'Senha',
                    obscureText: false,
                    prefixIcon: Icons.lock,
                    suffixIcon: null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Campo obrigatório';
                      }

                      if (controller.verifyPassword(meeting.password) == false) {
                        return 'Senha incorreta';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: CustomButton.standard(
                      buttonIsLoading: controller.buttonCheckPresenceIsLoading,
                      onPressed: () async {
                        final response = await controller.checkPresence(meeting);
                        if (response) {
                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      label: 'Confirmar',
                      height: 35,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
