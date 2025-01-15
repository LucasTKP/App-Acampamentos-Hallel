import 'package:acamps_canaa/core/dependencies_injection.dart';
import 'package:acamps_canaa/core/repositories/auth_repository.dart';
import 'package:acamps_canaa/core/utils/show_message.dart';
import 'package:acamps_canaa/ui/login/login_controller.dart';
import 'package:acamps_canaa/ui/login/login_screen.dart';
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
    authRepository = getIt<AuthRepositoryImpl>();
    controller = LoginControllerImpl(authRepository: authRepository, onShowMessage: onShowMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => LoginScreen(controller: controller),
      ),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
