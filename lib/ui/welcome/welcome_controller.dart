import 'package:app_acampamentos_hallel/core/global_controllers/settigs_controller.dart';
import 'package:app_acampamentos_hallel/core/libs/info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class WelcomeController extends ChangeNotifier {
  bool verifyVersion();
  Future<void> sendToGooglePlay();
}

class WelcomeControllerImpl extends WelcomeController {
  final SettingsController settingsController;

  WelcomeControllerImpl({required this.settingsController});

  @override
  bool verifyVersion() {
    if (settingsController.allSettings.versionApp != VersionApp().getVersion()) {
      return false;
    }
    return true;
  }

  @override
  Future<void> sendToGooglePlay() async {
      final Uri url = Uri.parse('https://acampscanaa.vercel.app/');

     if (!await launchUrl(url)) {
      throw Exception(url);
    }
  }
}
