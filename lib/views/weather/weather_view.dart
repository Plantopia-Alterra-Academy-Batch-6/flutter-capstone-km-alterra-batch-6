import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/weather_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/weather/weather_detail_view.dart';
import 'package:plantopia/views/weather/widget/current_weather_card_widget.dart';
import 'package:plantopia/views/weather/widget/hourly_weather_list_widget.dart';
import 'package:get/get.dart';
import 'package:plantopia/views/weather/widget/weather_info_humidity_widget.dart';
import 'package:plantopia/views/weather/widget/weather_info_real_feel_widget.dart';
import 'package:plantopia/views/weather/widget/weather_info_sunrise_widget.dart';
import 'package:plantopia/views/weather/widget/weather_info_wind_speed_widget.dart';

part 'widget/permission_location_widget.dart';

class WeatherView extends StatelessWidget {
  WeatherView({super.key}) {
    Get.lazyPut<WeatherController>(() => WeatherController());
  }

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.find<WeatherController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () {
          if (weatherController.locationPermissionDenied.value) {
            return PermissionLocationWidget(
              onPressed: () async {
                weatherController.currentWeatherStatus.value = Status.loading;
                weatherController.hourlyWeather.value = Status.loading;
                weatherController.dailyWeather.value = Status.loading;
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
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
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
                        weatherController.hourlyWeather.value,
                        () => HourlyWeatherListWidget(
                          weatherData:
                              weatherController.hourlyWeatherData.value,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () {
                      return _buildStatusWidget(
                        weatherController.currentWeatherStatus.value,
                        () => Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: WeatherInfoWindSpeedWidget(
                                    weatherData:
                                        weatherController.weatherData.value,
                                  ),
                                ),
                                const SizedBox(
                                    width:
                                        16), 
                                Expanded(
                                  child: WeatherInfoSunsetSunriseWidget(
                                    weatherData:
                                        weatherController.weatherData.value,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: WeatherInfoRealFeelWidget(
                                    weatherData:
                                        weatherController.weatherData.value,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: WeatherInfoHumidityWidget(
                                    weatherData:
                                        weatherController.weatherData.value,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
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
