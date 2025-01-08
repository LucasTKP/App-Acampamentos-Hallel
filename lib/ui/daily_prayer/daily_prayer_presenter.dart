import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/repositories/prayers_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/show_message.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/daily_prayer_controller.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/daily_prayer_screen.dart';
import 'package:flutter/material.dart';

class DailyPrayerPresenter extends StatefulWidget {
  const DailyPrayerPresenter({super.key});

  @override
  State<DailyPrayerPresenter> createState() => _DailyPrayerPresenterState();
}

class _DailyPrayerPresenterState extends State<DailyPrayerPresenter> {
  late DailyPrayerController controller;
  late UserController userController;

  @override
  void initState() {
    super.initState();
    userController = Dependencies.instance.get<UserControllerImpl>();
    controller = DailyPrayerControllerImpl(
      onShowMessage: onShowMessage,
      repository: Dependencies.instance.get<PrayersRepositoryImpl>(),
      userController: userController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return DailyPrayerScreen(controller: controller, user: userController.userLogged);
      },
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
