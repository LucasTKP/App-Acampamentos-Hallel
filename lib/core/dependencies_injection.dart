import 'package:acamps_canaa/core/global_controllers/settigs_controller.dart';
import 'package:acamps_canaa/core/global_controllers/user_controller.dart';
import 'package:acamps_canaa/core/libs/dio.dart';
import 'package:acamps_canaa/core/libs/firebase_service.dart';
import 'package:acamps_canaa/core/libs/permission_handler.dart';
import 'package:acamps_canaa/core/repositories/auth_repository.dart';
import 'package:acamps_canaa/core/repositories/liturgy_repository.dart';
import 'package:acamps_canaa/core/repositories/meetings_repository.dart';
import 'package:acamps_canaa/core/repositories/prayers_repository.dart';
import 'package:acamps_canaa/core/repositories/presences_repository.dart';
import 'package:acamps_canaa/core/repositories/settings_repository.dart';
import 'package:acamps_canaa/core/repositories/user_repository.dart';
import 'package:acamps_canaa/core/services/api_client.dart';
import 'package:acamps_canaa/core/services/auth_service.dart';
import 'package:acamps_canaa/core/services/liturgy_service.dart';
import 'package:acamps_canaa/core/services/meetings_service.dart';
import 'package:acamps_canaa/core/services/message_service.dart';
import 'package:acamps_canaa/core/services/prayers_service.dart';
import 'package:acamps_canaa/core/services/presences_service.dart';
import 'package:acamps_canaa/core/services/settings_service.dart';
import 'package:acamps_canaa/core/services/user.service.dart';
import 'package:acamps_canaa/ui/daily_prayer/daily_prayer_controller.dart';
import 'package:acamps_canaa/ui/today_birth/today_birth_controller.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton(() => MessageService());

  // API e Dio setup
  getIt.registerLazySingleton(() => DioConfig());
  getIt.registerLazySingleton(() => ApiService(client: getIt<DioConfig>().dio));

  // Settings
  getIt.registerLazySingleton(() => SettingsServiceImpl(db: db));
  getIt.registerLazySingleton(() => SettingsRepositoryImpl(settingsService: getIt<SettingsServiceImpl>()));
  getIt.registerLazySingleton(() => SettingsControllerImpl(settingsRepository: getIt<SettingsRepositoryImpl>()));

  // Liturgy
  getIt.registerLazySingleton(() => LiturgyServiceImpl(api: getIt<ApiService>()));
  getIt.registerLazySingleton(() => LiturgyRepositoryImpl(service: getIt<LiturgyServiceImpl>()));

  // Permission Handler
  getIt.registerLazySingleton(() => PermissionHandlerImpl());

  // Auth
  getIt.registerLazySingleton(() => AuthServiceImpl(auth: auth));
  getIt.registerLazySingleton(() => AuthRepositoryImpl(authService: getIt<AuthServiceImpl>()));

  // User
  getIt.registerLazySingleton(() => UserServiceImpl(api: getIt<ApiService>(), db: db, storage: storage));
  getIt.registerLazySingleton(() => UserRepositoryImpl(userService: getIt<UserServiceImpl>()));
  getIt.registerLazySingleton(() => UserControllerImpl());

  // Meetings
  getIt.registerLazySingleton(() => MeetingsServiceImpl(db: db));
  getIt.registerLazySingleton(() => MeetingsRepositoryImpl(service: getIt<MeetingsServiceImpl>()));

  // Presences
  getIt.registerLazySingleton(() => PresencesServiceImpl(db: db));
  getIt.registerLazySingleton(() => PresencesRepositoryImpl(service: getIt<PresencesServiceImpl>()));

  // Prayers
  getIt.registerLazySingleton(() => PrayersServiceImpl(db: db));
  getIt.registerLazySingleton(() => PrayersRepositoryImpl(service: getIt<PrayersServiceImpl>()));

  getIt.registerLazySingleton(() => DailyPrayerControllerImpl(messageService: getIt<MessageService>(), repository: getIt<PrayersRepositoryImpl>(), userController: getIt<UserControllerImpl>()));

  getIt.registerLazySingleton(() => TodayBirthControllerImpl(
        userRepository: getIt<UserRepositoryImpl>(),
        onShowMessage: getIt<MessageService>().showMessage,
      ));
}
