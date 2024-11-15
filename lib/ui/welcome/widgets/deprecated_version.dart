import 'package:app_acampamentos_hallel/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class DeprecatedVersion extends StatelessWidget {
  final Function sendToGooglePlayStore;
  const DeprecatedVersion({super.key, required this.sendToGooglePlayStore});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Stack(
        children: [
          Image.asset(
            'assets/images/welcome.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: const Color.fromARGB(255, 255, 255, 255),
                border: Border.all(color: ThemeColors.primaryColor, width: 3),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Aviso',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Seu aplicativo está desatualizado, clique no botão abaixo e atualize para a última versão.',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => sendToGooglePlayStore(),
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )),
                      side: WidgetStateProperty.all(
                        const BorderSide(color: ThemeColors.primaryColor, width: 2),
                      ),
                      visualDensity: VisualDensity.compact,
                      backgroundColor: WidgetStateProperty.all(ThemeColors.primaryColor.withOpacity(0.8)),
                    ),
                    child: const Text(
                      "Atualizar",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
