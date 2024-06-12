import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_current_weather_response_model.dart';
import 'package:plantopia/views/weather/widget/weather_date_time_widget.dart';
import 'package:plantopia/views/weather/widget/weather_temperature_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_svg/svg.dart';

part 'current_weather_location_widget.dart';
part 'current_weather_description_widget.dart';

class CurrentWeatherCardWidget extends StatelessWidget {
  final GetCurrentWeatherResponseModel weatherData;
  const CurrentWeatherCardWidget({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch((weatherData.dt ?? 0) * 1000);
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(dateTime);
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageConstant.background),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            CurrentWeatherLocationWidget(
              locationName: weatherData.name,
              locationCode: weatherData.sys?.country,
            ),
            const SizedBox(height: 8),
            WeatherDateTimeWidget(
              dateTime: formattedDate,
              textStyle: TextStyleConstant.caption.copyWith(
                color: ColorConstant.neutral0,
              ),
            ),
            WeatherTemperatureWidget(
                temperature: weatherData.main?.temp,
                textStyle: TextStyleConstant.superLarge),
            CurrentWeatherDescriptionWidget(
              description: weatherData.weather?.first.description,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
