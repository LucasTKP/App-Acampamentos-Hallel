import 'package:app_acampamentos_hallel/core/models/prayer.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/daily_prayer_controller.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_button.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_inputs.dart';
import 'package:flutter/material.dart';

void dialogPrayer({required BuildContext context, required DailyPrayerController controller, required PrayerModel? prayer}) {
  //prayer for != de null significa que está editando

  Future<void> onClickSave() async {
    if (prayer != null) {
      final result = await controller.updatePrayer(prayer);
      if (result) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.textEditingController.clear();
          Navigator.of(context).pop();
        });
      }
    } else {
      final result = await controller.createPrayer();
      if (result) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.textEditingController.clear();
          Navigator.of(context).pop();
        });
      }
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (prayer != null) {
        controller.textEditingController.text = prayer.text;
      } else {
        controller.textEditingController.clear();
      }
      return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Dialog(
            insetPadding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Form(
              key: controller.formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      prayer == null ? 'Cadastrar Oração' : 'Editar Oração',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('~ Orai uns pelos outros, para serdes curados. A oração feita pelo justo pode muito em seus efeitos ~', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 24),
                    Stack(
                      children: [
                        CustomInputs.standard(
                          label: 'Escreva seu pedido de oração',
                          controller: controller.textEditingController,
                          obscureText: false,
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                          prefixIcon: null,
                          suffixIcon: null,
                          maxLines: 4,
                        ),
                        const Positioned(
                          left: 10,
                          top: 15,
                          child: Icon(Icons.description, color: ThemeColors.primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: CustomButton.standard(
                        buttonIsLoading: controller.buttonSaveIsLoading,
                        label: 'Salvar',
                        onPressed: () async {
                          await onClickSave();
                        },
                        height: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
