import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/identify_error.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class RequestBirthdayController extends ChangeNotifier {
  bool buttonRequestBirthdayIsLoading = false;
  TextEditingController birthdayController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> updateBirthday();

  void setButtonRequestBirthdayInLoading(bool value);
}

class RequestBirthdayControllerImpl extends RequestBirthdayController {
  final UserRepository userRepository;
  final UserController userController;
  final Function({required String message, required Color color}) onShowMessage;

  RequestBirthdayControllerImpl({required this.userRepository, required this.userController, required this.onShowMessage});

  @override
  Future<void> updateBirthday() async {
    try {
      setButtonRequestBirthdayInLoading(true);
      if (formKey.currentState!.validate()) {
        await userRepository.updateUser(idUser: userController.user!.id, data: {'dateOfBirth': birthdayController.text});
        onShowMessage(message: 'Data de nascimento atualizada com sucesso', color: Colors.green);
        userController.setUser(userController.user!.copyWith(dateOfBirth: birthdayController.text));
      }
    } catch (e) {
      developer.log(e.toString());
      onShowMessage(message: identifyError(error: e, message: 'Erro ao atualizar data de nascimento'), color: Colors.red);
    } finally {
      setButtonRequestBirthdayInLoading(false);
    }
  }

  @override
  void setButtonRequestBirthdayInLoading(bool value) {
    buttonRequestBirthdayIsLoading = value;
    notifyListeners();
  }
}
