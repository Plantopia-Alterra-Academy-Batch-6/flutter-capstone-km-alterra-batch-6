import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/get_late_watering_response.dart';
import 'package:plantopia/models/get_notification_response.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';
import 'package:plantopia/utils/base_url_util.dart';

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

      await _notificationsPlugin.show(
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
    final token = await UserTokenPref.getToken();
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await dio.get(
          "${BaseUrlUtil.baseUrl}/notifications",
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return GetNotificationResponse.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load notification data : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> getNotificationById(int id) async {
    final token = await UserTokenPref.getToken();
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      await dio.get(
          "${BaseUrlUtil.baseUrl}/notifications/$id",
          options: Options(headers: headers));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<String> deleteAllNotification() async {
    final token = await UserTokenPref.getToken();
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await dio.delete(
          "${BaseUrlUtil.baseUrl}/notifications",
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        throw Exception(
            'Failed to delete notification data : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> createCustomizeReminder(
      {required int myPlantId,
      required String customizeTime,
      required bool isRecurring,
      required String type}) async {
    final token = await UserTokenPref.getToken();
    try {
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      await dio.post(
          "${BaseUrlUtil.baseUrl}/create-customize-watering-reminder",
          data: {
            "plant_id": myPlantId,
            "time": customizeTime,
            "recurring": isRecurring,
            "type": type
          },
          options: Options(headers: headers));
    } catch (e) {
      throw Exception('Failed to customize watering reminder $e');
    }
  }

  static Future<PlantByIdResponse> getPlantById(int id) async {
    try {
      final api =
          "${BaseUrlUtil.baseUrl}/plants/$id";
      final response = await dio.get(api);

      if (response.statusCode == 200) {
        return PlantByIdResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to get plant by id: ${response.statusCode}");
      }
    } on DioException {
      throw Exception("Failed to get plant id");
    }
  }

  static Future<GetLaterWateringResponse> getLateWatering() async {
    try {
      final token = await UserTokenPref.getToken();
      Map<String, dynamic> headers = {
        'Authorization': 'Bearer $token',
      };
      final response = await dio.get(
          "${BaseUrlUtil.baseUrl}/check-watering",
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return GetLaterWateringResponse.fromJson(response.data);
      } else {
        throw Exception("Failed to get late reminder: ${response.statusCode}");
      }
    } catch (e) {
      return GetLaterWateringResponse(data: null, message: null, status: null);
    }
  }
}