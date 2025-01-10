import 'package:app_acampamentos_hallel/core/models/user_model.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/core/utils/validate_cellphone.dart';
import 'package:app_acampamentos_hallel/core/utils/validate_date.dart';
import 'package:app_acampamentos_hallel/ui/dashboard_admin/dashboard.presenter.dart';
import 'package:app_acampamentos_hallel/ui/profile/profile_controller.dart';
import 'package:app_acampamentos_hallel/ui/profile/widgets/header.dart';
import 'package:app_acampamentos_hallel/ui/welcome/welcome_screen.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_drop_down.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller;
  final UserModel user;
  const ProfileScreen({super.key, required this.controller, required this.user});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(controller: controller),
          const SizedBox(height: 10),
          Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  CustomInputs.standard(
                    controller: controller.nameController,
                    label: 'Nome',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    prefixIcon: Icons.person,
                    suffixIcon: null,
                    enabled: controller.isEdit,
                  ),
                  Visibility(
                    visible: controller.isEdit == false,
                    child: const SizedBox(height: 16),
                  ),
                  Visibility(
                    visible: controller.isEdit == false,
                    child: CustomInputs.standard(
                      controller: controller.emailController,
                      label: 'E-mail',
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      prefixIcon: Icons.email,
                      suffixIcon: null,
                      enabled: false,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomInputs.standard(
                    controller: controller.dateOfBirthController,
                    label: 'Data de Nascimento',
                    obscureText: false,
                    validator: validateDate,
                    prefixIcon: Icons.calendar_today,
                    suffixIcon: null,
                    enabled: controller.isEdit,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '##/##/####',
                        filter: {'#': RegExp(r'[0-9]')},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomInputs.standard(
                    controller: controller.cellPhone,
                    label: 'Número de celular',
                    obscureText: false,
                    validator: validateCellPhone,
                    prefixIcon: Icons.phone,
                    suffixIcon: null,
                    enabled: controller.isEdit,
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '(##) #####-####',
                        filter: {'#': RegExp(r'[0-9]')},
                      ),
                    ],
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
                    value: controller.madeCamping,
                    validator: (value) {
                      if (value == null) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                    enabled: controller.isEdit,
                  ),
                  Visibility(visible: controller.madeCamping.value == 'true', child: const SizedBox(height: 16)),
                  Visibility(
                    visible: controller.madeCamping.value == 'true',
                    child: CustomDropDown.standard(
                      items: controller.itemsDropdownTwo,
                      onChanged: (value) {
                        if (value != null) {
                          controller.setMadeCaneYear(value);
                        }
                      },
                      textLabel: 'Em que ano você fez?',
                      icon: Icons.calendar_today,
                      value: controller.madeCaneYear,
                      validator: (value) {
                        if (value == null) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      enabled: controller.isEdit,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: controller.isEdit == false,
                    child: CustomInputs.standard(
                      controller: controller.totalPresenceController,
                      label: 'Total de presenças',
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      prefixIcon: Icons.calendar_today,
                      suffixIcon: null,
                      enabled: false,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (user.isAdmin)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardAdmin()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Painel do administrador',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final response = await controller.signOut();
                        if (response) {
                          if (context.mounted) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                                (Route<dynamic> route) => false,
                              );
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Sair da conta',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
