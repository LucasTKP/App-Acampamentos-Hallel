import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void dialogInfoApp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.info,
                color: Colors.black87,
                size: 50,
              ),
              const SizedBox(height: 16),
              const Text(
                'Este aplicativo foi desenvolvido sem fins lucrativos. Caso você tenha encontrado algum problema ou tenha alguma sugestão, entre em contato.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () async {
                  final Uri uri = Uri.parse('https://wa.me/5516991614062');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Não foi possível abrir o WhatsApp.'),
                        ),
                      );
                    });
                  }
                },
                icon: const Icon(Icons.message),
                label: const Text('Entrar em contato'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
