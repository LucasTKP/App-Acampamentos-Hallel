import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/home/home_presenter.dart';
import 'package:app_acampamentos_hallel/ui/login/login_controller.dart';
import 'package:app_acampamentos_hallel/ui/login/widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller;
  const LoginScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagem no fundo
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/login.png',
              fit: BoxFit.fitWidth,
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Bem-vindo de volta!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: ThemeColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '- o filho pródigo a casa torna -',
                      style: TextStyle(fontSize: 16, color: ThemeColors.primaryColor),
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          inputField(
                            controller: controller.emailController,
                            label: 'E-mail',
                            obscureText: false,
                            prefixIcon: Icons.person,
                            suffixIcon: null,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              }
                              final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Por favor, insira um email válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return inputField(
                                controller: controller.passwordController,
                                label: 'Senha',
                                obscureText: controller.isObscurePassword,
                                prefixIcon: Icons.lock,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.setIsObscurePassword(!controller.isObscurePassword);
                                    },
                                    icon: Icon(controller.isObscurePassword ? Icons.visibility_off : Icons.remove_red_eye),
                                    color: ThemeColors.primaryColor),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: controller.forgotPassword,
                              style: const ButtonStyle(visualDensity: VisualDensity.compact),
                              child: const Text('Esqueci minha senha >', style: TextStyle(color: ThemeColors.primaryColor)),
                            ),
                          ),
                          const SizedBox(height: 24),
                          AnimatedBuilder(
                            animation: controller,
                            builder: (context, child) {
                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  return OutlinedButton(
                                    onPressed: () async {
                                      if (controller.buttonLoginIsLoading) return;
                                      final response = await controller.login();
                                      if (response) {
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const HomePresenter(),
                                            ),
                                          );
                                        });
                                      }
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: ThemeColors.primaryColor,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(controller.buttonLoginIsLoading ? 100 : 10)),
                                    ),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      height: 45,
                                      width: controller.buttonLoginIsLoading ? 100 : constraints.maxWidth,
                                      curve: Curves.decelerate,
                                      alignment: Alignment.center,
                                      child: controller.buttonLoginIsLoading
                                          ? const SizedBox(
                                              height: 24,
                                              width: 24,
                                              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white), strokeWidth: 2.0),
                                            )
                                          : const Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 16)),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
