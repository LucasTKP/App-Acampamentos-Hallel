import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:acamps_canaa/core/utils/validate_date.dart';
import 'package:acamps_canaa/ui/register/register_user_controller.dart';
import 'package:acamps_canaa/ui/routes/routes.presenter.dart';
import 'package:acamps_canaa/ui/widgets/custom_button.dart';
import 'package:acamps_canaa/ui/widgets/custom_drop_down.dart';
import 'package:acamps_canaa/ui/widgets/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterUserScreen extends StatelessWidget {
  final RegisterUserController controller;
  const RegisterUserScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/login.png',
            fit: BoxFit.fitWidth,
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  const Text(
                    'Faça seu cadastro',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: ThemeColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '- Aqui é a sua Terra Prometida -',
                    style: TextStyle(fontSize: 16, color: ThemeColors.primaryColor),
                  ),
                  const SizedBox(height: 24),
                  CustomInputs.standard(
                    controller: controller.name,
                    contentPadding: EdgeInsets.zero,
                    label: 'Nome Completo',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    prefixIcon: Icons.person,
                    suffixIcon: null,
                  ),
                  const SizedBox(height: 16),
                  CustomInputs.standard(
                    controller: controller.email,
                    contentPadding: EdgeInsets.zero,
                    label: 'E-mail',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'E-mail inválido';
                      }
                      return null;
                    },
                    prefixIcon: Icons.email,
                    suffixIcon: null,
                  ),
                  const SizedBox(height: 16),
                  CustomInputs.standard(
                    controller: controller.dateOfBirth,
                    contentPadding: EdgeInsets.zero,
                    label: 'Data de Nascimento',
                    obscureText: false,
                    hintText: '11/11/2004',
                    validator: validateDate,
                    prefixIcon: Icons.date_range,
                    suffixIcon: null,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '##/##/####',
                        filter: {'#': RegExp(r'[0-9]')},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomInputs.standard(
                    controller: controller.password,
                    label: 'Senha',
                    obscureText: !controller.passwordVisible,
                    contentPadding: EdgeInsets.zero,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (value.length < 6) {
                        return 'Senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                    prefixIcon: Icons.lock,
                    suffixIcon: IconButton(
                      focusNode: FocusNode(skipTraversal: true),
                      onPressed: () {
                        controller.setPasswordVisible(!controller.passwordVisible);
                      },
                      icon: Icon(controller.passwordVisible ? Icons.visibility : Icons.visibility_off, color: ThemeColors.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomInputs.standard(
                    controller: controller.confirmPassword,
                    label: 'Confirme a senha',
                    obscureText: !controller.passwordVisible,
                    contentPadding: EdgeInsets.zero,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      if (value != controller.password.text) {
                        return 'as Senhas são difetentes';
                      }
                      return null;
                    },
                    prefixIcon: Icons.lock,
                    suffixIcon: IconButton(
                      focusNode: FocusNode(skipTraversal: true),
                      onPressed: () {
                        controller.setPasswordVisible(!controller.passwordVisible);
                      },
                      icon: Icon(controller.passwordVisible ? Icons.visibility : Icons.visibility_off, color: ThemeColors.primaryColor),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomDropDown.standard(
                    items: controller.itemsDropdownOne,
                    onChanged: (value) {
                      if (value != null) {
                        controller.setMadeCamping(value);
                      }
                    },
                    textLabel: 'Já fez o acampamento?',
                    icon: Icons.park,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    value: controller.madeCamping,
                    validator: (value) {
                      if (value == null) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: controller.madeCamping.value == 'true',
                    child: CustomDropDown.standard(
                      items: controller.itemsDropdownTwo,
                      onChanged: (value) {
                        if (value != null) {
                          controller.setYear(value);
                        }
                      },
                      textLabel: 'Em que ano você fez?',
                      icon: Icons.calendar_today,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      value: controller.year,
                      validator: (value) {
                        if (value == null) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomButton.standard(
                    buttonIsLoading: controller.buttonIsLoading,
                    onPressed: () async {
                      final response = await controller.onRegisterUser();
                      if (response) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RoutesPresenter(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        });
                      }
                    },
                    label: 'Cadastrar',
                  ),
                ],
              )),
        )
      ],
    );
  }
}
