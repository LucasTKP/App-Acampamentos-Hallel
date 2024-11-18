import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:app_acampamentos_hallel/ui/home/home_presenter.dart';
import 'package:app_acampamentos_hallel/ui/login/login_controller.dart';
import 'package:flutter/material.dart';

Widget buttonLogin({
  required LoginController controller,
}) {
  return AnimatedBuilder(
    animation: controller,
    builder: (context, child) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return OutlinedButton(
            onPressed: () async {
              if (controller.buttonLoginIsLoading) return;
              final response = await controller.login();
              if (response) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePresenter(),
                    ),
                  );
                });
              }
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: ThemeColors.primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(controller.buttonLoginIsLoading ? 100 : 10)),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 45,
              width: controller.buttonLoginIsLoading ? 100 : constraints.maxWidth,
              curve: Curves.decelerate,
              alignment: Alignment.center,
              child: controller.buttonLoginIsLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white), strokeWidth: 2.0),
                    )
                  : const Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          );
        },
      );
    },
  );
}
