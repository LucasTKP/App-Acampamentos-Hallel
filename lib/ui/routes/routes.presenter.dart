import 'package:app_acampamentos_hallel/core/models/routes.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/home/home_presenter.dart';
import 'package:app_acampamentos_hallel/ui/routes/routes_controller.dart';
import 'package:flutter/material.dart';

class RoutesPresenter extends StatefulWidget {
  const RoutesPresenter({super.key});

  @override
  State<RoutesPresenter> createState() => _RoutesPresenterState();
}

class _RoutesPresenterState extends State<RoutesPresenter> {
  late RoutesController controller;

  @override
  void initState() {
    controller = RoutesControllerImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          switch (controller.currentRoute) {
            case Routes.home:
              return const HomePresenter();
            case Routes.profile:
              return const Center(child: Text('Perfil'));
            case Routes.users:
              return const Center(child: Text('Usuários'));
            case Routes.meetings:
              return const Center(child: Text('Reuniões'));
          }
        },
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.grey),
                activeIcon: Icon(Icons.home, color: ThemeColors.primaryColor),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business, color: Colors.grey),
                activeIcon: Icon(Icons.business, color: ThemeColors.primaryColor),
                label: 'Perfil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school, color: Colors.grey),
                activeIcon: Icon(Icons.school, color: ThemeColors.primaryColor),
                label: 'Usuários',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school, color: Colors.grey),
                activeIcon: Icon(Icons.school, color: ThemeColors.primaryColor),
                label: 'Reuniões',
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
    );
  }
}