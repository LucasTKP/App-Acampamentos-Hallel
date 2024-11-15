import 'package:package_info_plus/package_info_plus.dart';

class VersionApp {
  static String version = "1.0.1";
  pubGetVersion() async {
    final pubInfo = await PackageInfo.fromPlatform();
    version = pubInfo.version;
  }

  String getVersion() {
    return version;
  }
}