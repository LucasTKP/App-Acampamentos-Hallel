import 'package:acamps_canaa/core/models/settings_model.dart';
import 'package:acamps_canaa/core/services/settings_service.dart';

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
