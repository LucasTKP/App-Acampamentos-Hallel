import 'package:app_acampamentos_hallel/core/global_controllers/settigs_controller.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/libs/dio.dart';
import 'package:app_acampamentos_hallel/core/libs/firebase_service.dart';
import 'package:app_acampamentos_hallel/core/libs/permission_handler.dart';
import 'package:app_acampamentos_hallel/core/repositories/auth_repository.dart';
import 'package:app_acampamentos_hallel/core/repositories/daily_liturgy_repository.dart';
import 'package:app_acampamentos_hallel/core/repositories/settings_repository.dart';
import 'package:app_acampamentos_hallel/core/repositories/user_repository.dart';
import 'package:app_acampamentos_hallel/core/services/api_client.dart';
import 'package:app_acampamentos_hallel/core/services/auth_service.dart';
import 'package:app_acampamentos_hallel/core/services/daily_liturgy_service.dart';
import 'package:app_acampamentos_hallel/core/services/settings_service.dart';
import 'package:app_acampamentos_hallel/core/services/user.service.dart';
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
  final DioConfig dioConfig = DioConfig();
  final ApiService api = ApiService(client: dioConfig.dio);
  Dependencies.instance.add<ApiService>(api);

  final settingsService = SettingsServiceImpl(db: db);
  final settingsRepository = SettingsRepositoryImpl(settingsService: settingsService);
  Dependencies.instance.add<SettingsRepositoryImpl>(settingsRepository);

  final dailyLiturgyService = DailyLiturgyServiceImpl(api: api);
  Dependencies.instance.add<DailyLiturgyRepository>(DailyLiturgyRepositoryImpl(service: dailyLiturgyService));



  Dependencies.instance.add<SettingsControllerImpl>(SettingsControllerImpl(settingsRepository: settingsRepository));

  Dependencies.instance.add<PermissionHandlerImpl>(PermissionHandlerImpl());

  final authService = AuthServiceImpl(auth: auth);
  Dependencies.instance.add<AuthRepositoryImpl>(AuthRepositoryImpl(authService: authService));

  final userService = UserServiceImpl();
  Dependencies.instance.add<UserRepositoryImpl>(UserRepositoryImpl(userService: userService));

  final userController = UserControllerImpl();
  Dependencies.instance.add<UserControllerImpl>(userController);

  return true;
}
