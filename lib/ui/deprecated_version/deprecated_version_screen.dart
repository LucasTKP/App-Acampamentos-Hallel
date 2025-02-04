import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeprecatedVersionScreen extends StatelessWidget {
  const DeprecatedVersionScreen({super.key});

  Future<void> sendToGooglePlay() async {
    final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.hallel.acamps_canaa');

    if (!await launchUrl(url)) {
      throw Exception(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/welcome.png',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.error,
            color: Colors.black87,
          ),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black, decoration: TextDecoration.none),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Seu aplicativo está desatualizado, clique no botão abaixo e atualize para a última versão.',
                  style: TextStyle(fontSize: 16, color: Colors.black, decoration: TextDecoration.none),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => sendToGooglePlay(),
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
    );
  }
}
