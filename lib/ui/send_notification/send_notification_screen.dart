import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/send_notification/send_notification_controller.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_button.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_inputs.dart';
import 'package:flutter/material.dart';

class SendNotificationScreen extends StatelessWidget {
  final SendNotificationController controller;
  const SendNotificationScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: controller.formKey,
        //dois campos para pegar titulo e descrição usando CustomInput.standard
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Text(
              "As notificações serão enviadas para todos os usuários, usem com sabedoria",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            CustomInputs.standard(
              controller: controller.titleController,
              label: "Título",
              obscureText: false,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Campo obrigatório';
                }
                if (value != null && value.length > 26) {
                  return 'Título muito grande, o máximo é de 26 caracteres';
                }
                return null;
              },
              prefixIcon: Icons.text_fields,
              suffixIcon: null,
            ),
            const SizedBox(height: 16),
            Stack(children: [
              CustomInputs.standard(
                  controller: controller.descriptionController,
                  label: "Descrição",
                  obscureText: false,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    if (value != null && value.length > 120) {
                      return 'Descrição muito grande, o máximo é de 120 caracteres';
                    }
                    return null;
                  },
                  prefixIcon: null,
                  suffixIcon: null,
                  maxLines: 5),
              const Positioned(
                left: 10,
                top: 15,
                child: Icon(Icons.description, color: ThemeColors.primaryColor),
              ),
            ]),
            const SizedBox(height: 24),
            CustomButton.standard(
              buttonIsLoading: controller.buttonIsLoading,
              onPressed: controller.sendNotification,
              label: "Enviar Notificação",
            )
          ],
        ),
      ),
    );
  }
}
