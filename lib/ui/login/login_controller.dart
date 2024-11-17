import 'package:app_acampamentos_hallel/core/repositories/auth_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/identify_error.dart';
import 'package:flutter/material.dart';

abstract class LoginController extends ChangeNotifier {
  bool buttonLoginIsLoading = false;
  bool isObscurePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<bool> login();
  Future<void> forgotPassword();

  void setButtonLoginInLoading(bool value);
  void setIsObscurePassword(bool value);
}

class LoginControllerImpl extends LoginController {
  final AuthRepository authRepository;
  final Function({required String message, required Color color}) onShowMessage;

  LoginControllerImpl({required this.authRepository, required this.onShowMessage});

  @override
  Future<bool> login() async {
    try {
      setButtonLoginInLoading(true);
      if (formKey.currentState!.validate()) {
        await authRepository.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        return true;
      }
      return false;
    } catch (e) {
      onShowMessage(message: identifyError(error: e, message: 'Erro ao fazer login'), color: Colors.red);
      return false;
    } finally {
      setButtonLoginInLoading(false);
    }
  }

  @override
  Future<void> forgotPassword() async{
    try {
      final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

      if (emailController.text.isEmpty || !emailRegex.hasMatch(emailController.text)) {
        onShowMessage(message: 'Informe o email válido para redefinir a senha', color: Colors.red);
        return;
      }

      await authRepository.forgotPassword(email: emailController.text);
      onShowMessage(message: 'Enviamos um email para redefinir a senha', color: Colors.green);
    } catch (e) {
      onShowMessage(message: identifyError(error: e, message: 'Erro ao enviar email de redefinição'), color: Colors.red);
    }
  }

  @override
  void setButtonLoginInLoading(bool value) {
    buttonLoginIsLoading = value;
    notifyListeners();
  }

  @override
  void setIsObscurePassword(bool value) {
    isObscurePassword = value;
    notifyListeners();
  }
}
