import 'package:app_acampamentos_hallel/core/utils/validate_date.dart';
import 'package:app_acampamentos_hallel/ui/profile/profile_controller.dart';
import 'package:app_acampamentos_hallel/ui/profile/widgets/header.dart';
import 'package:app_acampamentos_hallel/ui/welcome/welcome_screen.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_drop_down.dart';
import 'package:app_acampamentos_hallel/ui/widgets/custom_inputs.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller;
  const ProfileScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(controller: controller),
          const SizedBox(height: 40),
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
