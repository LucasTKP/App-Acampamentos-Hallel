import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/settigs_controller.dart';
import 'package:app_acampamentos_hallel/ui/welcome/welcome_controller.dart';
import 'package:app_acampamentos_hallel/ui/welcome/welcome_screen.dart';
import 'package:app_acampamentos_hallel/ui/welcome/widgets/deprecated_version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class WelcomePresenter extends StatefulWidget {
  const WelcomePresenter({super.key});

  @override
  State<WelcomePresenter> createState() => _WelcomePresenterState();
}

class _WelcomePresenterState extends State<WelcomePresenter> {
  late SettingsController settingsController;
  late WelcomeController controller;

  @override
  void initState() {
    super.initState();
    settingsController = Dependencies.instance.get<SettingsControllerImpl>();
    controller = WelcomeControllerImpl(settingsController: settingsController);
  }

  @override
  void dispose() {
    settingsController.dispose();
    super.dispose();
  }

  Widget getChild() {
    FlutterNativeSplash.remove();
    if (controller.verifyVersion()) {
      return WelcomeScreen(controller: controller);
    }
    return DeprecatedVersion(sendToGooglePlayStore: controller.sendToGooglePlay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getChild(),
    );
  }
}
