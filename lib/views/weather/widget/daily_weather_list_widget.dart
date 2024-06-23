import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/weather_controller.dart';
import 'package:plantopia/models/get_daily_weather_response_model.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/shimmer_container_global_widget.dart';
import 'package:plantopia/views/weather/widget/weather_date_time_widget.dart';
import 'package:plantopia/views/weather/widget/weather_image_widget.dart';
import 'package:plantopia/views/weather/widget/weather_temperature_widget.dart';
import 'package:intl/intl.dart';

part 'daily_weather_list_item_widget.dart';

class DailyWeatherListWidget extends StatelessWidget {
  const DailyWeatherListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherController weatherController = Get.put(WeatherController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Obx(
        () {
          switch (weatherController.dailyWeather.value) {
            case Status.loading:
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 7,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: ShimmerContainerGlobalWidget(
                      width: double.infinity,
                      height: 50,
                      radius: 16,
                    ),
                  );
                },
              );
            case Status.loaded:
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    weatherController.dailyWeatherData.value.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final weatherDataItem =
                      weatherController.dailyWeatherData.value.data?[index];
                  return DailyWeatherListItemWidget(
                    dailyWeather: weatherDataItem,
                  );
                },
              );
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
        },
      ),
    );
  }
}
