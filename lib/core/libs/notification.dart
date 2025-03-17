import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer' as developer;



@pragma('vm:entry-point')
class NotificationController {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'your_channel_id';
  static const _channelName = 'your_channel_name';
  static const _channelDesc = 'your_channel_description';

  static Future<void> init() async {
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

    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      developer.log("App opened from background via notification");
      _handleMessage(message);
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      developer.log("Got a message in foreground");
      _handleMessage(message);
    });
  }

  static void _handleMessage(RemoteMessage message) {
    if (message.notification != null) {
      final payload = jsonEncode(message.data);
      showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payload,
      );
    }
  }

  static Future<void> localNotiInit() async {
    const androidSettings = AndroidInitializationSettings('@drawable/launcher_icon');
    const iosSettings = DarwinInitializationSettings();
    const linuxSettings = LinuxInitializationSettings(defaultActionName: 'Open notification');

    const initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings, linux: linuxSettings);

    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  static void onNotificationTap(NotificationResponse response) {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      developer.log('Notification tapped with payload: $data');
    }
  }

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
      playSound: true,
      largeIcon: DrawableResourceAndroidBitmap('@drawable/android12splash'),
      color: Colors.green,
      colorized: true,
      ledColor: Colors.red,
      ledOnMs: 500,
      ledOffMs: 500,
      styleInformation: DefaultStyleInformation(true, true),
      ticker: 'ticker',
    );

    const details = NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
        0,
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

