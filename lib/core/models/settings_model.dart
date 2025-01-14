class SettingsModel {
  String versionApp;

  SettingsModel({
    required this.versionApp,
  });

  factory SettingsModel.fromJSON(Map<String, dynamic> json) {
    return SettingsModel(
      versionApp: json['version_app'],
    );
  }

  @override
  String toString() {
    return 'SettingsModel(versionApp: $versionApp)';
  }
}
