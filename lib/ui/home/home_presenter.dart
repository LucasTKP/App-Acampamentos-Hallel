import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/libs/permission_handler.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/daily_prayer_presenter.dart';
import 'package:app_acampamentos_hallel/ui/examination_conscience/exame_conscience.dart';
import 'package:app_acampamentos_hallel/ui/home/widgets/dialog_notification_disabled.dart';
import 'package:app_acampamentos_hallel/ui/today_birth/today_birth_presenter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePresenter extends StatefulWidget {
  const HomePresenter({super.key});

  @override
  State<HomePresenter> createState() => _HomePresenterState();
}

class _HomePresenterState extends State<HomePresenter> with WidgetsBindingObserver {
  late PermissionHandlerImpl permissionHandler;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    permissionHandler = Dependencies.instance.get<PermissionHandlerImpl>();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/home.png',
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
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
                    const SizedBox(height: 16),
                    const TodayBirthPresenter(),
                    const SizedBox(height: 24),
                    const DailyPrayerPresenter(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          //quero borda redonda
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: const Color.fromARGB(255, 238, 220, 117),

          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ExameConscience()));
          },
          child: const Icon(Icons.psychology),
        ),
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
