import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_forecast_by_hour_response_model.dart';
import 'package:plantopia/views/weather/widget/weather_image_widget.dart';
import 'package:plantopia/views/weather/widget/weather_temperature_widget.dart';
import 'package:plantopia/views/weather/widget/weather_date_time_widget.dart';

class ForecastByHourListItemWidget extends StatelessWidget {
  final ListElement forecastByHourListElement;
  final bool isFirstItem;
  const ForecastByHourListItemWidget({
    super.key,
    required this.forecastByHourListElement,
    required this.isFirstItem,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        (forecastByHourListElement.dt ?? 0) * 1000);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.5,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
          color: isFirstItem ? ColorConstant.blueLink50 : null,
        ),
        child: Column(
          children: [
            WeatherDateTimeWidget(
              dateTime: formattedTime,
              textStyle: TextStyleConstant.bodySmall,
            ),
            const SizedBox(
              height: 8,
            ),
            WeatherImageWidget(
              description: forecastByHourListElement.weather?.first.description,
            ),
            const SizedBox(
              height: 8,
            ),
            WeatherTemperatureWidget(
              temperature: forecastByHourListElement.main?.temp,
            ),
          ],
        ),
      ),
    );
  }
}
