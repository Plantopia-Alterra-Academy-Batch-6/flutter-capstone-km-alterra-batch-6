import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_current_weather_response_model.dart';
import 'package:plantopia/views/weather/widget/weather_date_time_widget.dart';
import 'package:plantopia/views/weather/widget/weather_temperature_widget.dart';
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
    DateTime dateTime = weatherData.data?.createdAt ?? DateTime.now();

    // Adjust time to GMT+7
    dateTime = dateTime.toUtc().add(const Duration(hours: 7));

    // Print the current time in GMT+7
    print('Current time in GMT+7: ${dateTime.hour}:${dateTime.minute}:${dateTime.second}');
    
    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(dateTime);

    final int hour = dateTime.hour;
    String backgroundImage;

    if (hour >= 6 && hour < 15) {
      backgroundImage = ImageConstant.weatherBackgroundLight;
    } else if (hour >= 15 && hour < 18) {
      backgroundImage = ImageConstant.weatherBackgroundAfternoon;
    } else {
      backgroundImage = ImageConstant.weatherBackgroundNight;
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            CurrentWeatherLocationWidget(
              locationName: weatherData.data?.city,
            ),
            const SizedBox(height: 8),
            WeatherDateTimeWidget(
              dateTime: formattedDate,
              textStyle: TextStyleConstant.caption.copyWith(
                color: ColorConstant.neutral0,
              ),
            ),
            WeatherTemperatureWidget(
                temperature: weatherData.data?.temperature?.toDouble() ?? 0,
                textStyle: TextStyleConstant.superLarge),
            CurrentWeatherDescriptionWidget(
              description: weatherData.data?.description,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
