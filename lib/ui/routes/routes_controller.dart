import 'package:acamps_canaa/core/global_controllers/user_controller.dart';
import 'package:acamps_canaa/core/models/async_state.dart';
import 'package:acamps_canaa/core/models/routes.dart';
import 'package:acamps_canaa/core/repositories/auth_repository.dart';
import 'package:acamps_canaa/core/repositories/user_repository.dart';
import 'package:acamps_canaa/core/utils/identify_error.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class RoutesController extends ChangeNotifier {
  AsyncState state = AsyncState.initial;
  Routes currentRoute = Routes.home;

  Future<void> init();
  Future<bool> getUser();
  List<Routes> routes = Routes.values;
  int getCurrentIndex();
  Future<void> subscribeToTopic();

  void setCurrentRoute(Routes route);
  void setAsyncState(AsyncState asyncState);
}

class RoutesControllerImpl extends RoutesController {
  final UserController userController;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final Function({required String message, required Color color}) onShowMessage;

  RoutesControllerImpl({required this.userController, required this.authRepository, required this.userRepository, required this.onShowMessage}) {
    userController.addListener(notifyListeners);
    getUser();
  }

  @override
  void dispose() {
    userController.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Future<void> init() async {
    setAsyncState(AsyncState.loading);
    final response = await getUser();
    if (response) {
      setAsyncState(AsyncState.initial);
    }
  }

  @override
  Future<bool> getUser() async {
    try {
      final userAuth = authRepository.getCurrentUser();
      if (userAuth != null) {
        final user = await userRepository.getUser(userAuth.uid);
        userController.setUser(user);
        await subscribeToTopic();
        return true;
      }
      return false;
    } catch (e) {
      developer.log(e.toString());
      onShowMessage(message: identifyError(error: e, message: 'Erro ao buscar o usuário.'), color: Colors.red);
      return false;
    }
  }

  @override
  Future<void> subscribeToTopic() async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic("all");
    } catch (e) {
      developer.log(e.toString());
    }
  }

  @override
  int getCurrentIndex() {
    return routes.indexOf(currentRoute);
  }

  @override
  setCurrentRoute(Routes route) {
    currentRoute = route;
    notifyListeners();
  }

  @override
  void setAsyncState(AsyncState asyncState) {
    state = asyncState;
    notifyListeners();
  }
}
