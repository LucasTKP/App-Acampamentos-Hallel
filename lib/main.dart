import 'package:acamps_canaa/core/dependencies_injection.dart';
import 'package:acamps_canaa/core/global_controllers/settigs_controller.dart';
import 'package:acamps_canaa/core/global_controllers/user_controller.dart';
import 'package:acamps_canaa/core/libs/firebase_options.dart';
import 'package:acamps_canaa/core/libs/firebase_service.dart';
import 'package:acamps_canaa/core/libs/info_plus.dart';
import 'package:acamps_canaa/core/libs/notification.dart';
import 'package:acamps_canaa/core/libs/permission_handler.dart';
import 'package:acamps_canaa/core/repositories/auth_repository.dart';
import 'package:acamps_canaa/core/services/message_service.dart';
import 'package:acamps_canaa/core/utils/theme_colors.dart';
import 'package:acamps_canaa/ui/deprecated_version/deprecated_version_screen.dart';
import 'package:acamps_canaa/ui/routes/routes.presenter.dart';
import 'package:acamps_canaa/ui/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationController.localNotiInit();
  await NotificationController.init();
  await setupDependencies();
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
        scaffoldMessengerKey: MessageService.scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: const Color(0xFFF3F3F3),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(fontSize: 22, color: Colors.white), iconTheme: IconThemeData(color: Colors.white), centerTitle: true, backgroundColor: ThemeColors.primaryColor),
        ),
        home: const InjectionPage(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
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
    userController = getIt<UserControllerImpl>();
    permissionHandler = getIt<PermissionHandlerImpl>();
    settingsController = getIt<SettingsControllerImpl>();
    authRepository = getIt<AuthRepositoryImpl>();
    auth.setLanguageCode("pt");
    requestPermissionNotification();
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
        return SafeArea(child: getChild());
      },
    );
  }
}
