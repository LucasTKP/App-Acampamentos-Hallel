import 'package:app_acampamentos_hallel/core/extensions/string_extension.dart';
import 'package:app_acampamentos_hallel/core/models/dropdown.dart';
import 'package:app_acampamentos_hallel/core/repositories/auth_repository.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/identify_error.dart';
import 'package:app_acampamentos_hallel/ui/register/register_user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class RegisterUserController extends ChangeNotifier {
  bool buttonIsLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  List<DropdownModel> itemsDropdownOne = [DropdownModel(value: 'true', label: 'Sim'), DropdownModel(value: 'false', label: 'Não')];
  List<DropdownModel> itemsDropdownTwo = List.generate(18, (index) => DropdownModel(value: '${2024 - index}', label: '${2024 - index}')).toList();
  late DropdownModel madeCamping;
  late DropdownModel year;
  bool passwordVisible = false;

  Future<bool> onRegisterUser();
  Future<UserCredential> onRegitserUserAuth();
  Future<void> onRegisterUserFirestore(String id);

  void setButtonIsLoading(bool value);
  void setMadeCamping(DropdownModel value);
  void setYear(DropdownModel value);
  void setPasswordVisible(bool value);
}

class RegisterUserControllerImpl extends RegisterUserController {
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final Function({required String message, required Color color}) onShowMessage;

  RegisterUserControllerImpl({required this.authRepository, required this.userRepository, required this.onShowMessage}) {
    setMadeCamping(itemsDropdownOne.last);
    setYear(itemsDropdownTwo.first);
  }

  @override
  Future<bool> onRegisterUser() async {
    try {
      if (!formKey.currentState!.validate()) return false;
      setButtonIsLoading(true);
      final userCredential = await onRegitserUserAuth();
      if (userCredential.user != null) {
        await onRegisterUserFirestore(userCredential.user!.uid);
        onShowMessage(message: 'Usuário cadastrado com sucesso', color: Colors.green);
        return true;
      }
      return false;
    } catch (e) {
      developer.log(e.toString());
      onShowMessage(message: identifyError(error: e, message: 'Erro ao cadastrar usuário'), color: Colors.red);
      return false;
    } finally {
      setButtonIsLoading(false);
    }
  }

  @override
  Future<UserCredential> onRegitserUserAuth() async {
    final userAuth = RegisterAuthUserDTO(email: email.text, password: password.text);

    return await authRepository.registerUser(userAuth);
  }

  @override
  Future<void> onRegisterUserFirestore(String id) async {
    final userFirestore = RegisteUserDto(
      id: id,
      name: name.text,
      email: email.text,
      madeCane: bool.parse(madeCamping.value),
      namePhoto: 'jesus.jpg',
      photoUrl: 'https://firebasestorage.googleapis.com/v0/b/canaa-afb9f.appspot.com/o/imageProfile%2Fjesus.jpg?alt=media&token=2c88b915-676a-46d4-8b5a-887c11ea714c',
      madeCaneYear: null,
      totalPresence: 0,
      lastPresence: DateTime.now(),
      dateOfBirth: dateOfBirth.text.toTimestamp(),
    );
    if (bool.parse(madeCamping.value)) {
      userFirestore.madeCaneYear = int.parse(year.value);
    }

    return await userRepository.registerUser(userFirestore);
  }

  @override
  void setButtonIsLoading(bool value) {
    buttonIsLoading = value;
    notifyListeners();
  }

  @override
  void setMadeCamping(DropdownModel value) {
    madeCamping = value;
    notifyListeners();
  }

  @override
  void setYear(DropdownModel value) {
    year = value;
    notifyListeners();
  }

  @override
  void setPasswordVisible(bool value) {
    passwordVisible = value;
    notifyListeners();
  }
}
