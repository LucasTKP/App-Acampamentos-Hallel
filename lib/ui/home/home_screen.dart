import 'package:app_acampamentos_hallel/core/libs/permission_handler.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/home/home_controller.dart';
import 'package:app_acampamentos_hallel/ui/home/widgets/dialog_notification_disabled.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatelessWidget {
  final HomeControllerImpl controller;
  final PermissionHandlerImpl permissionHandler;
  const HomeScreen({super.key, required this.controller, required this.permissionHandler});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Início',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -6),
                    child: Container(
                      width: 80,
                      height: 5,
                      color: ThemeColors.primaryColor,
                    ),
                  ),
                ],
              ),
              FutureBuilder<Widget>(
                future: getButtonNotificationDisabled(context),
                builder: (context, snapshot) {
                  return snapshot.data ?? const SizedBox();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<Widget> getButtonNotificationDisabled(BuildContext context) async {
    if (await permissionHandler.checkPermissionStatus(Permission.notification) == PermissionStatus.granted) {
      return const SizedBox();
    }

    return IconButton(
      onPressed: () {
        dialogNotificationDisabled(context);
      },
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.yellow[600]),
      ),
      icon: const Icon(
        Icons.notification_important,
      ),
    );
  }
}
