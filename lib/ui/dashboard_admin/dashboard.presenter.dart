import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/ui/send_notification/send_notification_presenter.dart';
import 'package:flutter/material.dart';

class DashboardAdmin extends StatefulWidget {
  const DashboardAdmin({super.key});

  @override
  State<DashboardAdmin> createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  late UserController userController;
  @override
  void initState() {
    userController = getIt<UserControllerImpl>();
    final user = userController.userLogged;
    if (user.isAdmin == false) {
      Navigator.of(context).pop();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Painel de administração'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SendNotificationPresenter()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  iconColor: Colors.black87,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enviar notificação',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.notifications),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
