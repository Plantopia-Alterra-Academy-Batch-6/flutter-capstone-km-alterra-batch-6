import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:plantopia/helpers/fcm_token.dart';
import 'package:plantopia/service/firebase_messaging_service.dart';
import 'package:plantopia/service/notification_service.dart';
import 'package:plantopia/splash_screen_view.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/auth/allow_notif_view.dart';
import 'package:plantopia/views/auth/auth_view.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_bar_global_widget.dart';
import 'package:plantopia/views/home/home_view.dart';
import 'package:plantopia/views/onboarding/onboarding_view.dart';
import 'package:plantopia/views/weather/weather_view.dart';

import 'firebase_options.dart';



Future<void> main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("look!!!, this is fcm token :$fcmToken");
  (fcmToken != null) ? await FcmTokenPref.setToken(fcmToken) : null;

  FirebaseMessagingService.initialize();

  runApp(
    GetMaterialApp(
      home: const BottomNavigationBarGlobalWidget(),
      getPages: [
        GetPage(
          name: AppRoutes.home,
          page: () => const HomeView(),
        ),
        GetPage(
          name: AppRoutes.weather,
          page: () => WeatherView(),
        ),
        GetPage(
          name: AppRoutes.splashApp,
          page: () => const SplashScreenView(),
        ),
        GetPage(
          name: AppRoutes.auth,
          page: () => const AuthView(),
        ),
        GetPage(
          name: AppRoutes.allowNotif,
          page: () => const AllowNotificationView(),
        ),
        GetPage(
          name: AppRoutes.onboarding,
          page: () => const OnboardingView(),
        ),
      ],
      initialRoute: AppRoutes.splashApp,
    ),
  );
}
