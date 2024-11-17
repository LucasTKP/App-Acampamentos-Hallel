import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/repositories/auth_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/show_message.dart';
import 'package:app_acampamentos_hallel/ui/login/login_controller.dart';
import 'package:app_acampamentos_hallel/ui/login/login_screen.dart';
import 'package:flutter/material.dart';

class LoginPresenter extends StatefulWidget {
  const LoginPresenter({super.key});

  @override
  State<LoginPresenter> createState() => _LoginPresenterState();
}

class _LoginPresenterState extends State<LoginPresenter> {
  late AuthRepository authRepository;
  late LoginController controller;

  @override
  void initState() {
    super.initState();
    authRepository = Dependencies.instance.get<AuthRepositoryImpl>();
    controller = LoginControllerImpl(authRepository: authRepository, onShowMessage: onShowMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreen(controller: controller),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
