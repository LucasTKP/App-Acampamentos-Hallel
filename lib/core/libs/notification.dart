import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer' as developer;

class NotificationController {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Constantes para configuração do canal de notificação
  static const _channelId = 'your_channel_id';
  static const _channelName = 'your_channel_name';
  static const _channelDesc = 'your_channel_description';

  // Solicitar permissão de notificação
  static Future<void> init() async {
    // Solicita permissões para enviar notificações
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    developer.log('User granted permission: ${settings.authorizationStatus}');

    // Configurar o gerenciador de mensagens em segundo plano
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);

    // Lidar com notificação quando o aplicativo está em segundo plano e o usuário toca nele
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      developer.log("App opened from background via notification");
      _handleMessage(message, isBackground: true);
    });

    // Lidar com notificação quando o aplicativo estiver em primeiro plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      developer.log("Got a message in foreground");
      print(message.notification);
      print('aaaaaaaaa');
      _handleMessage(message, isBackground: false);
    });
  }

  static void _handleMessage(RemoteMessage message, {required bool isBackground}) {
    if (message.notification != null) {
      final payload = jsonEncode(message.data);
      showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payload,
      );

      // Lida com qualquer lógica adicional baseada em if background/foreground
      if (isBackground) {
        // Navega para uma tela específica ou controla o toque em segundo plano
      }
    }
  }

  // Inicialize notificações locais
  static Future<void> localNotiInit() async {
    const androidSettings = AndroidInitializationSettings('@drawable/launcher_icon');
    const iosSettings = DarwinInitializationSettings();
    const linuxSettings = LinuxInitializationSettings(defaultActionName: 'Open notification');

    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings, linux: linuxSettings);

    // Solicitar permissão de notificação do Android 13+
    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  // Lidar com toque de notificação
  static void onNotificationTap(NotificationResponse response) {
    // Analisar a carga útil
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      developer.log('Notification tapped with payload: $data');

      // Navegue até a tela apropriada com base na carga útil
      // Example:
      // if (data['screen'] != null) {
      //   Navigator.pushNamed(context, data['screen']);
      // }
    }
  }

  // Mostrar uma notificação simples
  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.max,
      ticker: 'ticker',
    );

    const details = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
        0, // ID da notificação
        title,
        body,
        details,
        payload: payload);
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
    developer.log("Got a message in background");
    if (message.notification != null) {
      final payload = jsonEncode(message.data);
      await showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payload,
      );
    }
  }
}
