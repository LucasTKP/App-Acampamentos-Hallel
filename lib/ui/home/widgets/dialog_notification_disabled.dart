import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/libs/permission_handler.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';

void dialogNotificationDisabled(BuildContext context) {
  final PermissionHandlerImpl permissionHandler = Dependencies.instance.get<PermissionHandlerImpl>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Notificações desativadas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Para receber notificações e avisos importantes, ative as notificações nas configurações do aplicativo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  permissionHandler.openSettings();
                },
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(ThemeColors.primaryColor),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: const Text('Ativar notificações', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    },
  );
}