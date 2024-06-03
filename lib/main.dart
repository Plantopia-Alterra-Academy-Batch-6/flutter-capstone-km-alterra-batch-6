import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/weather/weather_view.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_bar_global_widget.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  runApp(
    GetMaterialApp(
      home: const BottomNavigationBarGlobalWidget(), 
      getPages: [
        GetPage(
          name: AppRoutes.weather,
          page: () => WeatherView(),
        ),
      ],
      // initialRoute: AppRoutes.splashScreen,
    ),
  );
}