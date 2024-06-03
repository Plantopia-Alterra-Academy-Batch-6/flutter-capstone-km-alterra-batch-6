import 'package:flutter/widgets.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class WeatherTemperatureWidget extends StatelessWidget {
  final double? temperature;
  final TextStyle? textStyle;

  const WeatherTemperatureWidget({
    super.key,
    required this.temperature,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final intTemperature = temperature?.toInt() ?? 0;

    return Text(
      '$intTemperature°',
      style: textStyle ??
          TextStyleConstant.paragraph.copyWith(
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
