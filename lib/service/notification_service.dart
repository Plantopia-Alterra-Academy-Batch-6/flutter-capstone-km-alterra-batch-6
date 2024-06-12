import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );
    _notificationsPlugin.initialize(initializationSettings);
  }

  static void displayNotification(RemoteMessage remoteMessage) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          playSound: true,
          priority: Priority.high,
          importance: Importance.high,
        ),
      );

      _notificationsPlugin.show(
        id,
        remoteMessage.notification?.title,
        remoteMessage.notification?.body,
        notificationDetails,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
