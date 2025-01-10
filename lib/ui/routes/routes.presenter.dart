import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/models/routes.dart';
import 'package:app_acampamentos_hallel/core/repositories/auth_repository.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/home/home_presenter.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/liturgy_presenter.dart';
import 'package:app_acampamentos_hallel/ui/meetings/meetings_presenter.dart';
import 'package:app_acampamentos_hallel/ui/profile/profile_presenter.dart';
import 'package:app_acampamentos_hallel/ui/request_birthday/request_birthday_presenter.dart';
import 'package:app_acampamentos_hallel/ui/request_cellphone/request_cellphone_presenter.dart';
import 'package:app_acampamentos_hallel/ui/routes/routes_controller.dart';
import 'package:flutter/material.dart';

class RoutesPresenter extends StatefulWidget {
  const RoutesPresenter({super.key});

  @override
  State<RoutesPresenter> createState() => _RoutesPresenterState();
}

class _RoutesPresenterState extends State<RoutesPresenter> {
  late UserController userController;
  late AuthRepository authRepository;
  late UserRepository userRepository;
  late RoutesController controller;

  @override
  void initState() {
    userController = Dependencies.instance.get<UserControllerImpl>();
    authRepository = Dependencies.instance.get<AuthRepositoryImpl>();
    userRepository = Dependencies.instance.get<UserRepositoryImpl>();
    controller = RoutesControllerImpl(
      userController: userController,
      authRepository: authRepository,
      userRepository: userRepository,
      onShowMessage: onShowMessage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            if (controller.state == AsyncState.loading || userController.user == null) {
              return const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor));
            }

            if (userController.user?.dateOfBirth == null) {
              return const RequestDateOfBirthday();
            }

            if(userController.user?.cellPhone == null) {
              return const RequestCellPhonePresenter();
            }

            switch (controller.currentRoute) {
              case Routes.meetings:
                return const MeetingsPresenter();
              case Routes.liturgy:
                return const LiturgyPresenter();
              case Routes.home:
                return const HomePresenter();
              case Routes.profile:
                return const ProfilePresenter();
            }
          },
        ),
        bottomNavigationBar: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            if (controller.state == AsyncState.loading || userController.user == null || userController.user?.dateOfBirth == null) {
              return const SizedBox();
            }
            return BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.event, color: Colors.grey),
                  activeIcon: Icon(Icons.event, color: ThemeColors.primaryColor),
                  label: 'Reuniões',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book, color: Colors.grey),
                  activeIcon: Icon(Icons.menu_book, color: ThemeColors.primaryColor),
                  label: 'Liturgia',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.grey),
                  activeIcon: Icon(Icons.home, color: ThemeColors.primaryColor),
                  label: 'Início',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.grey),
                  activeIcon: Icon(Icons.person, color: ThemeColors.primaryColor),
                  label: 'Perfil',
                ),
              ],
              currentIndex: controller.getCurrentIndex(),
              selectedItemColor: ThemeColors.primaryColor,
              onTap: (index) {
                controller.setCurrentRoute(Routes.values[index]);
              },
            );
          },
        ),
      ),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
