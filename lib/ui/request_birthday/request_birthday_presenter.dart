import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/show_message.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/core/utils/validate_date.dart';
import 'package:app_acampamentos_hallel/ui/request_birthday/request_birthday_controller.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_button.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RequestDateOfBirthday extends StatefulWidget {
  const RequestDateOfBirthday({super.key});

  @override
  State<RequestDateOfBirthday> createState() => _RequestDateOfBirthdayState();
}

class _RequestDateOfBirthdayState extends State<RequestDateOfBirthday> {
  late RequestBirthdayController controller;

  @override
  void initState() {
    controller = RequestBirthdayControllerImpl(
      userRepository: Dependencies.instance.get<UserRepositoryImpl>(),
      userController: Dependencies.instance.get<UserControllerImpl>(),
      onShowMessage: onShowMessage,
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/welcome.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: const Color.fromARGB(255, 255, 255, 255),
                border: Border.all(color: ThemeColors.primaryColor, width: 3),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Aviso',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black, decoration: TextDecoration.none),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Você precisa informar sua data de nascimento para continuar',
                    style: TextStyle(fontSize: 16, color: Colors.black, decoration: TextDecoration.none),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: controller.formKey,
                    child: CustomInputs.standard(
                      controller: controller.birthdayController,
                      contentPadding: EdgeInsets.zero,
                      label: 'Data de Nascimento',
                      obscureText: false,
                      hintText: '11/11/2004',
                      validator: validateDate,
                      prefixIcon: const Icon(Icons.date_range, color: ThemeColors.primaryColor, size: 26),
                      suffixIcon: null,
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: '##/##/####',
                          filter: {'#': RegExp(r'[0-9]')},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomButton.standard(
                    buttonIsLoading: controller.buttonRequestBirthdayIsLoading,
                    label: 'Atualizar',
                    onPressed: controller.updateBirthday,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
