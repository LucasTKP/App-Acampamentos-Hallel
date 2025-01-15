import 'package:acamps_canaa/core/dependencies_injection.dart';
import 'package:acamps_canaa/core/global_controllers/user_controller.dart';
import 'package:acamps_canaa/core/models/async_state.dart';
import 'package:acamps_canaa/core/repositories/auth_repository.dart';
import 'package:acamps_canaa/core/repositories/user_repository.dart';
import 'package:acamps_canaa/core/utils/show_message.dart';
import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:acamps_canaa/ui/profile/profile_controller.dart';
import 'package:acamps_canaa/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class ProfilePresenter extends StatefulWidget {
  const ProfilePresenter({super.key});

  @override
  State<ProfilePresenter> createState() => _ProfilePresenterState();
}

class _ProfilePresenterState extends State<ProfilePresenter> {
  late UserController userController;
  late UserRepository userRepository;
  late ProfileController controller;

  @override
  void initState() {
    userController = getIt<UserControllerImpl>();
    userRepository = getIt<UserRepositoryImpl>();
    controller = ProfileControllerImpl(
      userController: userController,
      userRepository: userRepository,
      onShowMessage: onShowMessage,
      authRepository: getIt<AuthRepositoryImpl>(),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          if (controller.asyncState == AsyncState.loading) {
            return const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor));
          }
          return ProfileScreen(controller: controller, user: userController.userLogged);
        },
      ),
      floatingActionButton: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          if (controller.asyncState == AsyncState.loading) {
            return const SizedBox();
          }
          return FloatingActionButton.small(
            backgroundColor: ThemeColors.primaryColor,
            onPressed: () {
              controller.isEdit ? controller.updateProfile() : controller.setIsEdit(true);
            },
            child: controller.isEdit ? const Icon(Icons.save, color: Colors.white) : const Icon(Icons.edit, color: Colors.white),
          );
        },
      ),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
