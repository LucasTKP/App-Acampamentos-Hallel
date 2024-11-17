import 'package:app_acampamentos_hallel/core/models/settings_model.dart';
import 'package:app_acampamentos_hallel/core/repositories/settings_repository.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

abstract class SettingsController extends ChangeNotifier {
  SettingsModel? settings;

  SettingsModel get allSettings => settings!;

  Future<void> getSettings();

  void setSettings(SettingsModel settings);
}

class SettingsControllerImpl extends SettingsController {
  final SettingsRepository settingsRepository;

  SettingsControllerImpl({required this.settingsRepository});

  @override
  Future<void> getSettings() async {
    try {
      final response = await settingsRepository.getSettings();
      setSettings(response);
    } catch (e) {
      developer.log(e.toString());
    }
  }


  @override
  void setSettings(SettingsModel settings) {
    this.settings = settings;
    notifyListeners();
  }
}
