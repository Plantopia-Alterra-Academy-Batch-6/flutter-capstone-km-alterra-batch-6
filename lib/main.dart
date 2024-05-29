
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/utils/app_routes.dart';

Future<void> main() async {
  runApp(
    GetMaterialApp(
      home: HomePage(), // home screen
      getPages: [
        GetPage(
          name: AppRoutes.splashScreen,
          page: () => SplashScreen(),
        ),

        GetPage(
          name: AppRoutes.splashScreen,
          page: () => HomePage(),
        ),

        // add more pages

      ],

      // add initial route (first page to be loaded is splash screen)
      initialRoute: AppRoutes.splashScreen,
    ),
  );
}
