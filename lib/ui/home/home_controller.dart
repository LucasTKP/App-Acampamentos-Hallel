import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/models/user_model.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class HomeController extends ChangeNotifier {
  AsyncState state = AsyncState.initial;
  List<UserModel> usersBirthdays = [];

  Future<void> init();
  Future<void> getUsersBirthday();

  void setAsyncState(AsyncState asyncState);
  void setUsersBirthdays(List<UserModel> value);
}

class HomeControllerImpl extends HomeController {
  final UserRepositoryImpl userRepository;
  final Function({required String message, required Color color}) onShowMessage;

  HomeControllerImpl({required this.userRepository, required this.onShowMessage}){
    init();
  }

  @override
  Future<void> init() async {
    await getUsersBirthday();
  }

  @override
  Future<void> getUsersBirthday() async {
    try {
      setAsyncState(AsyncState.loading);
      final users = await userRepository.getUserBirthdays();
      setUsersBirthdays(users);
      setAsyncState(AsyncState.initial);
    } catch (e) {
      developer.log('Buscar aniversariantes:', error: e);
      setAsyncState(AsyncState.error);
      onShowMessage(message: 'Erro ao buscar usuários', color: Colors.red);
    }
  }
  

  @override
  void setAsyncState(AsyncState asyncState) {
    state = asyncState;
    notifyListeners();
  }

  @override
  void setUsersBirthdays(List<UserModel> value) {
    usersBirthdays = value;
    notifyListeners();
  }
}
