import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/libs/permission_handler.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/daily_prayer/daily_prayer_presenter.dart';
import 'package:app_acampamentos_hallel/ui/examination_conscience/exame_conscience.dart';
import 'package:app_acampamentos_hallel/ui/home/widgets/dialog_info.dart';
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
    permissionHandler = getIt<PermissionHandlerImpl>();
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
                    IntrinsicHeight(
                      child: Row(
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
                                  fontWeight: FontWeight.w600,
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
                          InkWell(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ExameConscience()));
                            },
                            child: Container(
                              height: double.infinity,
                              alignment: Alignment.center,
                              child: const Text(
                                'Exame de consciência',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black54,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    FutureBuilder<Widget>(
                      future: getButtonNotificationDisabled(context),
                      builder: (context, snapshot) {
                        return snapshot.data ?? const SizedBox();
                      },
                    ),
                    const SizedBox(height: 16),
                    const TodayBirthPresenter(),
                    const SizedBox(height: 24),
                    const DailyPrayerPresenter(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.small(
          onPressed: () => dialogInfoApp(context),
          backgroundColor: Colors.yellow[300],
          child: const Icon(Icons.info, color: Colors.black87),
        ),
      ),
    );
  }

  Future<Widget> getButtonNotificationDisabled(BuildContext context) async {
    if (await permissionHandler.checkPermissionStatus(Permission.notification) == PermissionStatus.granted) {
      return const SizedBox();
    }

    return InkWell(
      onTap: () {
        dialogNotificationDisabled(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.yellow[800]!),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.info, color: Colors.yellow[800]),
            const SizedBox(width: 4),
            Expanded(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Notificações desativadas ",
                      style: TextStyle(color: Colors.yellow[800]),
                    ),
                    TextSpan(
                      text: "Clique Aqui",
                      style: TextStyle(
                        color: Colors.yellow[800],
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        decorationColor: Colors.yellow[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
