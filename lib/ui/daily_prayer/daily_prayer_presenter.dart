import 'package:acamps_canaa/core/dependencies_injection.dart';
import 'package:acamps_canaa/core/global_controllers/user_controller.dart';
import 'package:acamps_canaa/ui/daily_prayer/daily_prayer_controller.dart';
import 'package:acamps_canaa/ui/daily_prayer/daily_prayer_screen.dart';
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
    userController = getIt<UserControllerImpl>();
    controller = getIt<DailyPrayerControllerImpl>();
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
}
