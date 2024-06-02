import 'package:flutter/widgets.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class WeatherDateTimeWidget extends StatelessWidget {
  final String? dateTime;
  final TextStyle? textStyle;

  const WeatherDateTimeWidget({
    super.key,
    required this.dateTime,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime ?? '',
      style: textStyle ??
          TextStyleConstant.mediumText
    );
  }
}
