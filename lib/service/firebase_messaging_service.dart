import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:plantopia/service/notification_service.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  if (message.notification != null) {
    log('${message.notification?.title}');
    log('${message.notification?.body}');
    NotificationService.displayNotification(message);
  }
}

class FirebaseMessagingService {
  static void initialize() {
    NotificationService.initialize();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

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
