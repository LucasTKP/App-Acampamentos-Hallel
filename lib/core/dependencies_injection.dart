import 'package:app_acampamentos_hallel/core/global_controllers/settigs_controller.dart';
import 'package:app_acampamentos_hallel/core/libs/firebase_service.dart';
import 'package:app_acampamentos_hallel/core/repositories/settings_repository.dart';
import 'package:app_acampamentos_hallel/core/services/settings_service.dart';
import 'package:flutter/material.dart';

class Dependencies {
  static Dependencies? _instance;

  static Dependencies get instance => _instance ??= Dependencies._();

  Dependencies._();

  final Map<Type, dynamic> _objects = {};

  bool contains<T>() => _objects.containsKey(T);

  void add<T>(T instance) => contains<T>() ? throw Exception('Class ${T.runtimeType} already registered!') : _objects[T] = instance;

  T get<T>() => contains<T>() ? _objects[T] : throw Exception('Class ${T.runtimeType} not registered!');

  void remove<T>() => _objects.remove(T);

  void clear() => _objects.clear();
}

Future<bool> setupDependencies(BuildContext context) async {
  final settingsService = SettingsServiceImpl(db: db);
  final settingsRepository = SettingsRepositoryImpl(settingsService: settingsService);
  Dependencies.instance.add<SettingsRepositoryImpl>(settingsRepository);
  
  Dependencies.instance.add<SettingsControllerImpl>(SettingsControllerImpl(settingsRepository: settingsRepository));



  return true;
}
