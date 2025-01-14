import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/repositories/auth_repository.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/show_message.dart';
import 'package:app_acampamentos_hallel/ui/register/register_user_controller.dart';
import 'package:app_acampamentos_hallel/ui/register/register_user_screen.dart';
import 'package:flutter/material.dart';

class RegisterUserPresenter extends StatefulWidget {
  const RegisterUserPresenter({super.key});

  @override
  State<RegisterUserPresenter> createState() => _RegisterUserPresenterState();
}

class _RegisterUserPresenterState extends State<RegisterUserPresenter> {
  late UserRepository userRepository;
  late AuthRepository authRepository;
  late RegisterUserController controller;

  @override
  void initState() {
    super.initState();
    userRepository = getIt<UserRepositoryImpl>();
    authRepository = getIt<AuthRepositoryImpl>();
    controller = RegisterUserControllerImpl(
      authRepository: authRepository,
      userRepository: userRepository,
      onShowMessage: onShowMessage,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return RegisterUserScreen(controller: controller);
        },
      ),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
