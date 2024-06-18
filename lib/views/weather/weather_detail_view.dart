import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/weather_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/weather/widget/daily_weather_list_widget.dart';
import 'package:plantopia/views/weather/widget/hourly_weather_list_widget.dart';

class WeatherDetailView extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  WeatherDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Weather Detail',
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Obx(
              () {
                switch (weatherController.hourlyWeather.value) {
                  case Status.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.loaded:
                    return HourlyWeatherListWidget(
                        weatherData:
                            weatherController.hourlyWeatherData.value);
                  case Status.error:
                    return const Center(
                      child: Text(
                        "Failed to load forecast data. Please try again later. $e",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
            const SizedBox(
              height: 32,
            ),
            Obx(
              () {
                switch (weatherController.dailyWeather.value) {
                  case Status.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.loaded:
                    return DailyWeatherListWidget(
                        weatherData:
                            weatherController.dailyWeatherData.value);
                  case Status.error:
                    return const Center(
                      child: Text(
                        "Failed to load forecast data. Please try again later. $e",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
