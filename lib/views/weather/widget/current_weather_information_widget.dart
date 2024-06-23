
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/weather_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/weather/widget/weather_info_humidity_widget.dart';
import 'package:plantopia/views/weather/widget/weather_info_real_feel_widget.dart';
import 'package:plantopia/views/weather/widget/weather_info_sunrise_widget.dart';
import 'package:plantopia/views/weather/widget/weather_info_wind_speed_widget.dart';

class CurrentWeatherInformationWidget extends StatelessWidget {
  const CurrentWeatherInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController());

    return Obx(
      () {
        return _buildCurrentWeatherInformationWidgetStatus(
          weatherController.currentWeatherStatus.value,
          () => Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: WeatherInfoWindSpeedWidget(
                      weatherData: weatherController.weatherData.value,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: WeatherInfoSunsetSunriseWidget(
                      weatherData: weatherController.weatherData.value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: WeatherInfoRealFeelWidget(
                      weatherData: weatherController.weatherData.value,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: WeatherInfoHumidityWidget(
                      weatherData: weatherController.weatherData.value,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildCurrentWeatherInformationWidgetStatus(
    Status status, Widget Function() onSuccess) {
  switch (status) {
    case Status.loading:
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ShimmerContainerGlobalWidget(
                    width: 156,
                    height: 130,
                    radius: 16,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ShimmerContainerGlobalWidget(
                    width: 156,
                    height: 130,
                    radius: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ShimmerContainerGlobalWidget(
                    width: 156,
                    height: 130,
                    radius: 16,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ShimmerContainerGlobalWidget(
                    width: 156,
                    height: 130,
                    radius: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    case Status.loaded:
      return onSuccess();
    case Status.error:
      return Center(
        child: Text(
          "Failed to load hourly weather data. Please try again later.",
          style: TextStyleConstant.paragraph.copyWith(
            color: ColorConstant.danger500,
          ),
        ),
      );
    default:
      return const Center(
        child: CircularProgressIndicator(),
      );
  }
}