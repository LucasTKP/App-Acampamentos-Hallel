import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/repositories/auth_repository.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/show_message.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/profile/profile_controller.dart';
import 'package:app_acampamentos_hallel/ui/profile/profile_screen.dart';
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
    userController = Dependencies.instance.get<UserControllerImpl>();
    userRepository = Dependencies.instance.get<UserRepositoryImpl>();
    controller = ProfileControllerImpl(
      userController: userController,
      userRepository: userRepository,
      onShowMessage: onShowMessage,
      authRepository: Dependencies.instance.get<AuthRepositoryImpl>(),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            
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
