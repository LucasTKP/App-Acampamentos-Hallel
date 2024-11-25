import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/settigs_controller.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/user_controller.dart';
import 'package:app_acampamentos_hallel/core/libs/firebase_options.dart';
import 'package:app_acampamentos_hallel/core/libs/firebase_service.dart';
import 'package:app_acampamentos_hallel/core/libs/info_plus.dart';
import 'package:app_acampamentos_hallel/core/libs/notification.dart';
import 'package:app_acampamentos_hallel/core/libs/permission_handler.dart';
import 'package:app_acampamentos_hallel/core/repositories/auth_repository.dart';
import 'package:app_acampamentos_hallel/ui/deprecated_version/deprecated_version_screen.dart';
import 'package:app_acampamentos_hallel/ui/routes/routes.presenter.dart';
import 'package:app_acampamentos_hallel/ui/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationController.localNotiInit(); //Configs de notificação local
  await NotificationController.init(); //Configs de notificação do firebase

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    VersionApp().pubGetVersion();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: const Color(0xFFF3F3F3),
          useMaterial3: true,
        ),
        home: const InjectionPage(),
      ),
    );
  }
}

class InjectionPage extends StatefulWidget {
  const InjectionPage({super.key});

  @override
  State<InjectionPage> createState() => _InjectionPageState();
}

class _InjectionPageState extends State<InjectionPage> {
  late UserController userController;
  late PermissionHandler permissionHandler;
  late SettingsController settingsController;
  late AuthRepository authRepository;

  @override
  void initState() {
    super.initState();
    setupDependencies(context);
    userController = Dependencies.instance.get<UserControllerImpl>();
    permissionHandler = Dependencies.instance.get<PermissionHandlerImpl>();
    settingsController = Dependencies.instance.get<SettingsControllerImpl>();
    authRepository = Dependencies.instance.get<AuthRepositoryImpl>();
    auth.setLanguageCode("pt");
    requestPermissionNotification();
  }

  @override
  void dispose() {
    userController.dispose();
    settingsController.dispose();
    super.dispose();
  }

  void requestPermissionNotification() async {
    final status = await permissionHandler.checkPermissionStatus(Permission.notification);
    if (status.isGranted) {
      return;
    }
    await permissionHandler.requestPermission(Permission.notification);
  }

  Widget getChild() {
    FlutterNativeSplash.remove();
    if (settingsController.allSettings.versionApp != VersionApp().getVersion()) {
      return const DeprecatedVersionScreen();
    }

    if (authRepository.getCurrentUser() != null) {
      return const RoutesPresenter();
    }

    return const WelcomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (context, child) {
        if (settingsController.settings == null) {
          settingsController.getSettings();
          return const SizedBox();
        }
        return getChild();
      },
    );
  }
}
