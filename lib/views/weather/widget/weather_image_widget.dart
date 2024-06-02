import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantopia/constants/weather_condition_constant.dart';

class WeatherImageWidget extends StatelessWidget {
  final String? description;
  final double? width;
  final double? height;

  const WeatherImageWidget({
    super.key,
    required this.description,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      WeatherCondition.getWeatherDescriptionIcon(description ?? ''),
      width: width ?? 24,
      height: height ?? 24,
    );
  }
}
