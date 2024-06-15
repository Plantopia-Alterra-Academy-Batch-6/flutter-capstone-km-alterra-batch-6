import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plantopia/models/get_notification_response.dart';

class NotificationService {
  static Dio dio = Dio();

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

  static Future<GetNotificationResponse> getAllNotification() async {
    // final token = await UserTokenPref.getToken();
    try {
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im9jdGF2aWFub3J5YW4wMzBAZ21haWwuY29tIiwiaWQiOjMsInJvbGUiOiJ1c2VyIn0.7SvvgU6pwwe6cLg-M97O9PT5vHcKlizflp5M4XlPwHE',
      };
      final response = await dio.get(
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/notifications",
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return GetNotificationResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load notification data : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Notif> getNotificationById(int id) async {
    // final token = await UserTokenPref.getToken();
    try {
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im9jdGF2aWFub3J5YW4wMzBAZ21haWwuY29tIiwiaWQiOjMsInJvbGUiOiJ1c2VyIn0.7SvvgU6pwwe6cLg-M97O9PT5vHcKlizflp5M4XlPwHE',
      };
      final response = await dio.get(
          "https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1/notifications/$id",
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception('Failed to load notification data : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
