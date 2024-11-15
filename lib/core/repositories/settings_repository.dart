import 'package:app_acampamentos_hallel/core/models/settings_model.dart';
import 'package:app_acampamentos_hallel/core/services/settings_service.dart';

abstract class SettingsRepository {
  Future<SettingsModel> getSettings();
}

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsService settingsService;

  SettingsRepositoryImpl({required this.settingsService});

  @override
  Future<SettingsModel> getSettings() async {
    final response = await settingsService.getSettings();
    return SettingsModel.fromJSON(response);
  }
}
