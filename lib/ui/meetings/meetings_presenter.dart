import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/repositories/meetings_repository.dart';
import 'package:app_acampamentos_hallel/core/repositories/presences_repository.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/show_message.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/meetings/meetings_controller.dart';
import 'package:app_acampamentos_hallel/ui/meetings/meetings_screen.dart';
import 'package:flutter/material.dart';

class MeetingsPresenter extends StatefulWidget {
  const MeetingsPresenter({super.key});

  @override
  State<MeetingsPresenter> createState() => _MeetingsPresenterState();
}

class _MeetingsPresenterState extends State<MeetingsPresenter> {
  late MeetingsController controller;

  @override
  void initState() {
    controller = MeetingsControllerImpl(
      meetingsRepository: Dependencies.instance.get<MeetingsRepositoryImpl>(),
      presenceRepository: Dependencies.instance.get<PresencesRepositoryImpl>(),
      userRepository: Dependencies.instance.get<UserRepositoryImpl>(),
      userController: Dependencies.instance.get<UserControllerImpl>(),
      onShowMessage: onShowMessage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          if (controller.asyncState == AsyncState.loading) {
            return const Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor));
          }

          return MeetingsScreen(controller: controller);
        },
      ),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
