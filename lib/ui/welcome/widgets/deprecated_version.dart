import 'package:flutter/material.dart';

class DeprecatedVersion extends StatelessWidget {
  final Function sendToGooglePlayStore;
  const DeprecatedVersion({super.key, required this.sendToGooglePlayStore});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              color: const Color(0xFFFFE9A5),
              border: Border.all(color: const Color(0XFFBF9000), width: 3),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Aviso',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Seu aplicativo está desatualizado, clique no botão abaixo e atualize para a ultima versão.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => sendToGooglePlayStore(),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Color(0XFFBF9000), width: 2),
                      ),
                    ),
                    overlayColor: WidgetStateProperty.all(const Color(0xFFD5C681)),
                    backgroundColor: WidgetStateProperty.all(const Color(0xFFFFE9A5)),
                    visualDensity: VisualDensity.compact
                  ),
                  child: const Text(
                    "Atualizar",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
