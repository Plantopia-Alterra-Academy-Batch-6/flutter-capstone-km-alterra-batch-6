import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_hourly_weather_response_model.dart';
import 'package:plantopia/views/weather/widget/weather_date_time_widget.dart';
import 'package:plantopia/views/weather/widget/weather_image_widget.dart';
import 'package:plantopia/views/weather/widget/weather_temperature_widget.dart';
import 'package:intl/intl.dart';

part 'hourly_weather_list_item_widget.dart';

class HourlyWeatherListWidget extends StatelessWidget {
  final GetHourlyWeatherResponseModel weatherData;
  const HourlyWeatherListWidget({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: weatherData.data?.length ?? 0,
        itemBuilder: (context, index) {
          final weatherDataItem = weatherData.data?[index];
          final isFirstItem = index == 0;
          return HourlyWeatherListItemWidget(
            hourlyWeather: weatherDataItem,
            isFirstItem: isFirstItem,
          );
        },
      ),
    );
  }
}
