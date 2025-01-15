import 'package:acamps_canaa/core/global_controllers/user_controller.dart';
import 'package:acamps_canaa/core/repositories/user_repository.dart';
import 'package:acamps_canaa/core/utils/identify_error.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class RequestCellPhoneController extends ChangeNotifier {
  bool buttonRequestCellphoneIsLoading = false;
  TextEditingController cellPhoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> updateCellPhone();

  void setButtonRequestCellPhoneIsLoading(bool value);
}

class RequestCellPhoneControllerImpl extends RequestCellPhoneController {
  final UserRepository userRepository;
  final UserController userController;
  final Function({required String message, required Color color}) onShowMessage;

  RequestCellPhoneControllerImpl({required this.userRepository, required this.userController, required this.onShowMessage});

  @override
  Future<void> updateCellPhone() async {
    try {
      setButtonRequestCellPhoneIsLoading(true);
      if (formKey.currentState!.validate()) {
        final cellPhone = cellPhoneController.text;
        await userRepository.updateUser(idUser: userController.user!.id, data: {'cellPhone': cellPhone});
        onShowMessage(message: 'Número de celular atualizado com sucesso', color: Colors.green);
        userController.setUser(userController.user!.copyWith(cellPhone: cellPhone));
      }
    } catch (e) {
      developer.log(e.toString());
      onShowMessage(message: identifyError(error: e, message: 'Erro ao atualizar número de celular'), color: Colors.red);
    } finally {
      setButtonRequestCellPhoneIsLoading(false);
    }
  }

  @override
  void setButtonRequestCellPhoneIsLoading(bool value) {
    buttonRequestCellphoneIsLoading = value;
    notifyListeners();
  }
}
