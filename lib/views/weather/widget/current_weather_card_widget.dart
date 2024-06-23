import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/weather_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/weather/widget/weather_date_time_widget.dart';
import 'package:plantopia/views/weather/widget/weather_temperature_widget.dart';
import 'package:flutter_svg/svg.dart';

part 'current_weather_location_widget.dart';
part 'current_weather_description_widget.dart';

class CurrentWeatherCardWidget extends StatelessWidget {
  const CurrentWeatherCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController());

    DateTime dateTime =
        weatherController.weatherData.value.data?.createdAt ?? DateTime.now();

    dateTime = dateTime.toUtc().add(const Duration(hours: 7));
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(dateTime);
    final int hour = dateTime.hour;
    String backgroundImage;

    if (hour >= 6 && hour < 15) {
      backgroundImage = ImageConstant.weatherBackgroundLight;
    } else if (hour >= 15 && hour < 18) {
      backgroundImage = ImageConstant.weatherBackgroundAfternoon;
    } else {
      backgroundImage = ImageConstant.weatherBackgroundNight;
    }
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Obx(
            () {
              return _buildCurrentWeatherCardWidgetStatus(
                weatherController.currentWeatherStatus.value,
                () => Column(
                  children: [
                    const SizedBox(height: 16),
                    CurrentWeatherLocationWidget(
                      locationName:
                          weatherController.weatherData.value.data?.city,
                    ),
                    const SizedBox(height: 8),
                    WeatherDateTimeWidget(
                      dateTime: formattedDate,
                      textStyle: TextStyleConstant.caption.copyWith(
                        color: ColorConstant.neutral0,
                      ),
                    ),
                    WeatherTemperatureWidget(
                        temperature: weatherController
                                .weatherData.value.data?.temperature
                                ?.toDouble() ??
                            0,
                        textStyle: TextStyleConstant.superLarge),
                    CurrentWeatherDescriptionWidget(
                      description:
                          weatherController.weatherData.value.data?.description,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget _buildCurrentWeatherCardWidgetStatus(Status status, Widget Function() onSuccess) {
    switch (status) {
      case Status.loading:
        return const Center(
          child: ShimmerContainerGlobalWidget(
            width: double.infinity,
            height: 260,
            radius: 0,
          ),
        );
      case Status.loaded:
        return onSuccess();
      case Status.error:
        return Center(
          child: Text("Failed to load current weather. Please try again later.",
              style: TextStyleConstant.paragraph.copyWith(
                color: ColorConstant.danger500,
              )),
        );
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}

