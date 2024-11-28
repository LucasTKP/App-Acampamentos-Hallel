import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/libs/firebase_service.dart';
import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/models/routes.dart';
import 'package:app_acampamentos_hallel/core/models/user_model.dart';
import 'package:app_acampamentos_hallel/core/repositories/auth_repository.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/identify_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:developer' as developer;

abstract class RoutesController extends ChangeNotifier {
  AsyncState state = AsyncState.initial;
  Routes currentRoute = Routes.home;

  Future<void> init();
  Future<bool> getUser();
  Future<void> updateDeviceToken(UserModel user);
  List<Routes> routes = Routes.values;
  int getCurrentIndex();

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
        updateDeviceToken(user);
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
  Future<void> updateDeviceToken(UserModel user) async {
    final fcmToken = await messaging.getToken(vapidKey: dotenv.env['FIREBASE_WEB_VAPID']);
    if (fcmToken != null && userController.user?.deviceToken != fcmToken) {
      await userRepository.updateUser(userController.user!.id, {'deviceToken': fcmToken});
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
