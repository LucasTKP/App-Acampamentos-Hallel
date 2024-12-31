import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/libs/permission_handler.dart';
import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/show_message.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/home/home_controller.dart';
import 'package:app_acampamentos_hallel/ui/home/home_screen.dart';
import 'package:flutter/material.dart';

class HomePresenter extends StatefulWidget {
  const HomePresenter({super.key});

  @override
  State<HomePresenter> createState() => _HomePresenterState();
}

class _HomePresenterState extends State<HomePresenter> with WidgetsBindingObserver {
  late HomeControllerImpl controller;
  late PermissionHandlerImpl permissionHandler;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = HomeControllerImpl(
      userRepository: Dependencies.instance.get<UserRepositoryImpl>(),
      onShowMessage: onShowMessage,
    );
    permissionHandler = Dependencies.instance.get<PermissionHandlerImpl>();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    controller.setAsyncState(AsyncState.initial);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Image.asset(
              'assets/images/home.png',
              width: double.infinity,
            ),
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                if (controller.state == AsyncState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(color: ThemeColors.primaryColor),
                  );
                }
                return HomeScreen(controller: controller, permissionHandler: permissionHandler);
              },
            ),
          ],
        ),
      ),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
