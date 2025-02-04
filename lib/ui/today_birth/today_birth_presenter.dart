import 'package:acamps_canaa/core/dependencies_injection.dart';
import 'package:acamps_canaa/ui/today_birth/today_birth_controller.dart';
import 'package:acamps_canaa/ui/today_birth/today_birth_screen.dart';
import 'package:flutter/material.dart';

class TodayBirthPresenter extends StatefulWidget {
  const TodayBirthPresenter({super.key});

  @override
  State<TodayBirthPresenter> createState() => _TodayBirthPresenterState();
}

class _TodayBirthPresenterState extends State<TodayBirthPresenter> {
  late TodayBirthController controller;

  @override
  void initState() {
    super.initState();
    controller = getIt<TodayBirthControllerImpl>();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return TodayBirthScreen(controller: controller);
      },
    );
  }
}
