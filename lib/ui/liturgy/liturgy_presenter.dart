import 'package:acamps_canaa/core/dependencies_injection.dart';
import 'package:acamps_canaa/core/models/async_state.dart';
import 'package:acamps_canaa/core/repositories/liturgy_repository.dart';
import 'package:acamps_canaa/core/utils/show_message.dart';
import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:acamps_canaa/ui/generic_error/generic_error.dart';
import 'package:acamps_canaa/ui/liturgy/liturgy_controller.dart';
import 'package:acamps_canaa/ui/liturgy/liturgy_screen.dart';
import 'package:flutter/material.dart';

class LiturgyPresenter extends StatefulWidget {
  const LiturgyPresenter({super.key});

  @override
  State<LiturgyPresenter> createState() => _LiturgyPresenterState();
}

class _LiturgyPresenterState extends State<LiturgyPresenter> {
  late LiturgyController controller;

  @override
  void initState() {
    super.initState();
    controller = LiturgyControllerImpl(
      liturgyRepository: getIt<LiturgyRepositoryImpl>(),
      onShowMessage: onShowMessage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          if (controller.asyncState == AsyncState.loading) {
            return const Center(
              child: CircularProgressIndicator(color: ThemeColors.primaryColor),
            );
          }

          if (controller.asyncState == AsyncState.error) {
            return GenericErrorScreen(
              retry: () {
                controller.getLiturgy();
              },
            );
          }

          return LiturgyScreen(controller: controller);
        },
      ),
    );
  }

  void onShowMessage({required String message, required Color color}) {
    showMessage(context: context, message: message, color: color);
  }
}
