import 'package:app_acampamentos_hallel/core/models/routes.dart';
import 'package:flutter/material.dart';

abstract class RoutesController extends ChangeNotifier {
  Routes currentRoute = Routes.home;

  List<Routes> routes = Routes.values;
  int getCurrentIndex();

  setCurrentRoute(Routes route);
}

class RoutesControllerImpl extends RoutesController {

  @override
  int getCurrentIndex() {
    return routes.indexOf(currentRoute);
  }


  @override
  setCurrentRoute(Routes route) {
    currentRoute = route;
    notifyListeners();
  }
}
