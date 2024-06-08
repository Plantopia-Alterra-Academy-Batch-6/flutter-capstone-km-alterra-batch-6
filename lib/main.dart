import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/history_plant/history_plant_view.dart';
import 'package:plantopia/views/home/home_view.dart';
import 'package:plantopia/views/my_plant/my_plant_view.dart';
import 'package:plantopia/views/weather/weather_view.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_bar_global_widget.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

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
          name: AppRoutes.myPlant,
          page: () => MyPlantView(),
        ),
        GetPage(
          name: AppRoutes.historyPlant,
          page: () => const HistoryPlantView(),
        ),
      ],
      // initialRoute: AppRoutes.splashScreen,
    ),
  );
}