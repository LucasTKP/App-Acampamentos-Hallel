import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class CustomButton {
  static Widget standard({
    required bool buttonIsLoading,
    required Function onPressed,
    required String label,
    double height = 45,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OutlinedButton(
          onPressed: (){
            if (!buttonIsLoading) {
              onPressed();
            }
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: ThemeColors.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonIsLoading ? 100 : 10)),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: height,
            width: buttonIsLoading ? 100 : constraints.maxWidth,
            curve: Curves.decelerate,
            alignment: Alignment.center,
            
            child: buttonIsLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white), strokeWidth: 2.0),
                  )
                : Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
        );
      },
    );
  }
}
