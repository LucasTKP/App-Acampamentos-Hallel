import 'package:acamps_canaa/core/dependencies_injection.dart';
import 'package:acamps_canaa/core/repositories/user_repository.dart';
import 'package:acamps_canaa/core/utils/show_message.dart';
import 'package:acamps_canaa/ui/send_notification/send_notification_controller.dart';
import 'package:acamps_canaa/ui/send_notification/send_notification_screen.dart';
import 'package:flutter/material.dart';

class SendNotificationPresenter extends StatefulWidget {
  const SendNotificationPresenter({super.key});

  @override
  State<SendNotificationPresenter> createState() => _SendNotificationPresenterState();
}

class _SendNotificationPresenterState extends State<SendNotificationPresenter> {
  late SendNotificationControllerImpl controller;

  @override
  void initState() {
    super.initState();
    controller = SendNotificationControllerImpl(
      userRepository: getIt<UserRepositoryImpl>(),
      onShowMessage: onShowMessage,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Envie Notificações'),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return SendNotificationScreen(controller: controller);
        },
      ),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
