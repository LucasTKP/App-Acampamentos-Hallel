// ignore_for_file: public_member_api_docs, sort_constructors_first
class SettingsModel {
  String versionApp;
  String nameApp;
  String pathLogo;
  String primaryColor;


  SettingsModel({
    required this.versionApp,
    required this.nameApp,
    required this.pathLogo,
    required this.primaryColor,
  });


  factory SettingsModel.fromJSON(Map<String, dynamic> json) {
    return SettingsModel(
      versionApp: json['version_app'],
      nameApp: json['camp_name'],
      pathLogo: json['path_logo'],
      primaryColor: json['primary_color'],
    );
  }

  

  @override
  String toString() {
    return 'SettingsModel(versionApp: $versionApp, nameApp: $nameApp, pathLogo: $pathLogo, primaryColor: $primaryColor)';
  }
}
