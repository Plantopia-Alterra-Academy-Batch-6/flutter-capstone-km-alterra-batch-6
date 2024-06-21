import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_daily_weather_response_model.dart';
import 'package:plantopia/views/weather/widget/weather_date_time_widget.dart';
import 'package:plantopia/views/weather/widget/weather_image_widget.dart';
import 'package:plantopia/views/weather/widget/weather_temperature_widget.dart';
import 'package:intl/intl.dart';

part 'daily_weather_list_item_widget.dart';

class DailyWeatherListWidget extends StatelessWidget {
  final GetDailyWeatherResponseModel weatherData;
  const DailyWeatherListWidget({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: weatherData.data?.length ?? 0,
        itemBuilder: (context, index) {
          final weatherDataItem = weatherData.data?[index];
          return DailyWeatherListItemWidget(
            dailyWeather: weatherDataItem,
          );
        },
      ),
    );
  }
}
