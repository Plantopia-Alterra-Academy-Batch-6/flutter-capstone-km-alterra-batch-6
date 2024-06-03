import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/weather_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/weather/weather_detail_view.dart';
import 'package:plantopia/views/weather/widget/current_weather_card_widget.dart';
import 'package:plantopia/views/weather/widget/forecast_by_hour_list_widget.dart';
import 'package:get/get.dart';

part 'widget/permission_location_widget.dart';

class WeatherView extends StatelessWidget {
  WeatherView({super.key}) {
    Get.lazyPut<WeatherController>(() => WeatherController());
  }

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.find<WeatherController>();

    return Scaffold(
      body: Obx(
        () {
          if (weatherController.locationPermissionDenied.value) {
            return PermissionLocationWidget(
              onPressed: () async {
                weatherController.currentWeatherStatus.value =
                    Status.loading;
                weatherController.forecastByHour.value = Status.loading;
                weatherController.forecastByDay.value = Status.loading;
                await weatherController.requestLocationPermission();
                if (weatherController.locationPermissionGranted.value) {
                  await weatherController.getUserLocationAndWeather();
                }
              },
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Obx(
                    () {
                      return _buildStatusWidget(
                        weatherController.currentWeatherStatus.value,
                        () => CurrentWeatherCardWidget(
                          weatherData: weatherController.weatherData.value,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Today's Weather",
                          style: TextStyleConstant.heading4.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
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
                            style: TextStyleConstant.paragraph.copyWith(
                              color: ColorConstant.link500,
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
                      return _buildStatusWidget(
                        weatherController.forecastByHour.value,
                        () => ForecastByHourListWidget(
                          forecastByHourModel:
                              weatherController.forecastByHourData.value,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildStatusWidget(Status status, Widget Function() onSuccess) {
    switch (status) {
      case Status.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case Status.loaded:
        return onSuccess();
      case Status.error:
        return const Center(
          child: Text(
            "Failed to load data. Please try again later.",
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
        );
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}