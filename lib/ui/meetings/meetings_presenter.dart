import 'package:acamps_canaa/core/dependencies_injection.dart';
import 'package:acamps_canaa/core/global_controllers/user_controller.dart';
import 'package:acamps_canaa/core/models/async_state.dart';
import 'package:acamps_canaa/core/repositories/meetings_repository.dart';
import 'package:acamps_canaa/core/repositories/presences_repository.dart';
import 'package:acamps_canaa/core/repositories/user_repository.dart';
import 'package:acamps_canaa/core/utils/show_message.dart';
import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:acamps_canaa/ui/meetings/meetings_controller.dart';
import 'package:acamps_canaa/ui/meetings/meetings_screen.dart';
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
      meetingsRepository: getIt<MeetingsRepositoryImpl>(),
      presenceRepository: getIt<PresencesRepositoryImpl>(),
      userRepository: getIt<UserRepositoryImpl>(),
      userController: getIt<UserControllerImpl>(),
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
