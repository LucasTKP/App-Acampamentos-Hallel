import 'package:acamps_canaa/core/dependencies_injection.dart';
import 'package:acamps_canaa/core/repositories/user_repository.dart';
import 'package:acamps_canaa/core/utils/show_message.dart';
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
    controller = TodayBirthControllerImpl(
      userRepository: getIt<UserRepositoryImpl>(),
      onShowMessage: onShowMessage,
    );
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

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
