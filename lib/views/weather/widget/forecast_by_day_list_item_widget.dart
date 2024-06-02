import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_forecast_by_day_response_model.dart';
import 'package:plantopia/views/weather/widget/weather_image_widget.dart';
import 'package:plantopia/views/weather/widget/weather_temperature_widget.dart';
import 'package:plantopia/views/weather/widget/weather_date_time_widget.dart';

class ForecastByDayListItemWidget extends StatelessWidget {
  final ListElement forecastByDayListElement;
  const ForecastByDayListItemWidget({
    super.key,
    required this.forecastByDayListElement,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        (forecastByDayListElement.dt ?? 0) * 1000);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherDateTimeWidget(
            dateTime: formattedTime,
            textStyle: TextStyleConstant.mediumText.copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 8,
          ),
          WeatherTemperatureWidget(
            temperature: forecastByDayListElement.temp?.day,
            textStyle: TextStyleConstant.heading1Bold,
          ),
          const SizedBox(
            height: 8,
          ),
          WeatherImageWidget(
            description:
                forecastByDayListElement.weather?.first.description.toString(),
            height: 44,
            width: 44,
          ),
        ],
      ),
    );
  }
}
