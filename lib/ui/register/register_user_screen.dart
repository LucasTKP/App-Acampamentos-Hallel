import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/register/register_user_controller.dart';
import 'package:app_acampamentos_hallel/ui/routes/routes.presenter.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_button.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_drop_down.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_inputs.dart';
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
        Center(
          child: SingleChildScrollView(
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
                    const SizedBox(height: 16),
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
                      prefixIcon: const Icon(Icons.person, color: ThemeColors.primaryColor, size: 26),
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
                      prefixIcon: const Icon(Icons.email, color: ThemeColors.primaryColor, size: 26),
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
                      prefixIcon: const Icon(Icons.date_range, color: ThemeColors.primaryColor, size: 26),
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
                      prefixIcon: const Icon(Icons.lock, color: ThemeColors.primaryColor, size: 26),
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
                      prefixIcon: const Icon(Icons.lock, color: ThemeColors.primaryColor, size: 26),
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
                      textLabel: 'Você já fez o acampamento?',
                      icon: const Icon(Icons.park, color: ThemeColors.primaryColor, size: 26),
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
                        icon: const Icon(Icons.calendar_today, color: ThemeColors.primaryColor, size: 26),
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
                    const SizedBox(height: 64),
                    CustomButton.standard(
                      buttonIsLoading: controller.buttonIsLoading,
                      onPressed: () async {
                        final response = await controller.onRegisterUser();
                        if (response) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoutesPresenter(),
                              ),
                            );
                          });
                        }
                      },
                      label: 'Cadastrar',
                    )
                  ],
                )),
          ),
        )
      ],
    );
  }
}

String? validateDate(String? date) {
  if (date == null || date.isEmpty) {
    return 'Campo obrigatório';
  }

  // Validate date format (DD/MM/YYYY)
  final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
  if (!dateRegex.hasMatch(date)) {
    return 'Formato de data inválido, use 00/00/0000';
  }

  // Parse the date
  final parts = date.split('/');
  final day = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final year = int.tryParse(parts[2]);

  // Check if date components are valid
  if (day == null || month == null || year == null) {
    return 'Data inválida';
  }

  // Validate date range and format
  if (month < 1 || month > 12) {
    return 'Mês inválido';
  }

  final daysInMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  if (day < 1 || day > daysInMonth[month - 1]) {
    return 'Dia inválido';
  }

  // Optional: Age restrictions (e.g., must be at least 18)
  final now = DateTime.now();
  final birthDate = DateTime(year, month, day);
  final age = now.year - birthDate.year;

  if (age < 18 || (age == 18 && (now.month < month || (now.month == month && now.day < day)))) {
    return 'Você deve ter pelo menos 18 anos';
  }

  return null;
}
