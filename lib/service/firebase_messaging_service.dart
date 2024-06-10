import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:plantopia/service/notification_service.dart';

class FirebaseMessagingService {
  static void initialize() {
    NotificationService.initialize();

    Future<void> firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      if (message.notification != null) {
        log('${message.notification?.title}');
        log('${message.notification?.body}');
        NotificationService.displayNotification(message);
      }
    }

    //FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
