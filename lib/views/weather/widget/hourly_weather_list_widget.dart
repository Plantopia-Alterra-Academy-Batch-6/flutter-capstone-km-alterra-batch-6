import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/weather_controller.dart';
import 'package:plantopia/models/get_hourly_weather_response_model.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/weather/widget/weather_date_time_widget.dart';
import 'package:plantopia/views/weather/widget/weather_image_widget.dart';
import 'package:plantopia/views/weather/widget/weather_temperature_widget.dart';
import 'package:intl/intl.dart';

part 'hourly_weather_list_item_widget.dart';

class HourlyWeatherListWidget extends StatelessWidget {
  const HourlyWeatherListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController());

    return Obx(
      () {
        return _hourlyWeatherListWidgetStatus(
          weatherController.hourlyWeather.value,
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 94,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount:
                    weatherController.hourlyWeatherData.value.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final weatherDataItem =
                      weatherController.hourlyWeatherData.value.data?[index];
                  final isFirstItem = index == 0;
                  return HourlyWeatherListItemWidget(
                    hourlyWeather: weatherDataItem,
                    isFirstItem: isFirstItem,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _hourlyWeatherListWidgetStatus(
      Status status, Widget Function() onSuccess) {
    switch (status) {
      case Status.loading:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SizedBox(
            height: 94,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 48,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: ShimmerContainerGlobalWidget(
                    width: 56,
                    height: 94,
                    radius: 8,
                  ),
                );
              },
            ),
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
}
