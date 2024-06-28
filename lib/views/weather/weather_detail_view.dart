import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/views/weather/widget/daily_weather_list_widget.dart';
import 'package:plantopia/views/weather/widget/hourly_weather_list_widget.dart';

class WeatherDetailView extends StatelessWidget {
  const WeatherDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
        title: Text(
          'Weather Detail',
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            HourlyWeatherListWidget(),
            SizedBox(
              height: 32,
            ),
            DailyWeatherListWidget(),
          ],
        ),
      ),
    );
  }
}