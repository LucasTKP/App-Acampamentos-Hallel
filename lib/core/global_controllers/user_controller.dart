import 'package:app_acampamentos_hallel/core/models/user_model.dart';
import 'package:flutter/material.dart';

abstract class UserController extends ChangeNotifier {
  UserModel? user;

  UserModel get userLogged => user!;

  void setUser(UserModel user);
}

class UserControllerImpl extends UserController {
  @override
  void setUser(UserModel user) {
    this.user = user;
    notifyListeners();
  }
}
