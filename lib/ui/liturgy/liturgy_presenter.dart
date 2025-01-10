import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/models/async_state.dart';
import 'package:app_acampamentos_hallel/core/repositories/liturgy_repository.dart';
import 'package:app_acampamentos_hallel/core/utils/show_message.dart';
import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/generic_error/generic_error.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/liturgy_controller.dart';
import 'package:app_acampamentos_hallel/ui/liturgy/liturgy_screen.dart';
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
      liturgyRepository: Dependencies.instance.get<LiturgyRepositoryImpl>(),
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
