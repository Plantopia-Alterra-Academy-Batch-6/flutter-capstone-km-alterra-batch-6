import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/weather_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/weather/weather_detail_view.dart';
import 'package:plantopia/views/weather/widget/current_weather_card_widget.dart';
import 'package:plantopia/views/weather/widget/forecast_by_hour_list_widget.dart';

class WeatherView extends StatelessWidget {
  WeatherView({super.key}) {
    // Inisialisasi WeatherController hanya ketika WeatherView dibuat
    Get.lazyPut<WeatherController>(() => WeatherController());
  }

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.find<WeatherController>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () {
                switch (weatherController.currentWeatherStatus.value) {
                  case Status.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.loaded:
                    return Column(
                      children: [
                        CurrentWeatherCardWidget(
                          weatherData: weatherController.weatherData.value,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  case Status.error:
                    return const Center(
                      child: Text(
                        "Failed to load current weather data. Please try again later.",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Today's Weather",
                    style: TextStyleConstant.heading4Bold,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return WeatherDetailView();
                      }));
                    },
                    child: Text(
                      "View 7 days",
                      style: TextStyleConstant.regular.copyWith(
                        color: ColorConstant.blueLink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Obx(
              () {
                switch (weatherController.forecastByHour.value) {
                  case Status.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case Status.loaded:
                    return ForecastByHourListWidget(
                        forecastByHourModel:
                            weatherController.forecastByHourData.value);
                  case Status.error:
                    return const Center(
                      child: Text(
                        "Failed to load forecast data. Please try again later.",
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
