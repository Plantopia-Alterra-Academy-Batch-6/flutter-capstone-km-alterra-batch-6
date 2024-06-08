import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer';

import 'package:plantopia/service/notification_service.dart';

class FirebaseMessagingService {
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    log('Handling a background message: ${message.messageId}');
    // Tambahkan handler untuk background message jika diperlukan
  }

  static void initialize() {
    NotificationService.initialize();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.data}');

        if (message.notification != null) {
          log('${message.notification?.title}');
          log('${message.notification?.body}');
          NotificationService.displayNotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        log('Got a message whilst in the foreground!');
        log('Message data: ${message.data}');

        if (message.notification != null) {
          log('${message.notification?.title}');
          log('${message.notification?.body}');
          NotificationService.displayNotification(message);
        }
      },
    );
  }
}
