import 'package:app_acampamentos_hallel/core/dependencies_injection.dart';
import 'package:app_acampamentos_hallel/core/global_controllers/settigs_controller.dart';
import 'package:app_acampamentos_hallel/core/libs/firebase_options.dart';
import 'package:app_acampamentos_hallel/core/libs/info_plus.dart';
import 'package:app_acampamentos_hallel/ui/welcome/welcome_presenter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        ),
        home: const InjectionPage(
          child: WelcomePresenter(),
        ),
      ),
    );
  }
}

class InjectionPage extends StatefulWidget {
  final Widget child;
  const InjectionPage({super.key, required this.child});

  @override
  State<InjectionPage> createState() => _InjectionPageState();
}

class _InjectionPageState extends State<InjectionPage> {
  late SettingsController settingsController;

  @override
  void initState() {
    super.initState();
    setupDependencies(context);
    settingsController = Dependencies.instance.get<SettingsControllerImpl>();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (context, child) {
        if (settingsController.settings == null) {
          settingsController.getSettings();
          return const Placeholder();
        }
        return widget.child;
      },
    );
  }
}
