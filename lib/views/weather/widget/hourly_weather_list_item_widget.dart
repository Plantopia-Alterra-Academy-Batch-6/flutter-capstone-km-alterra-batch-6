part of 'hourly_weather_list_widget.dart';

class HourlyWeatherListItemWidget extends StatelessWidget {
  final HourlyWeather? hourlyWeather;
  final bool isFirstItem;
  const HourlyWeatherListItemWidget({
    super.key,
    required this.hourlyWeather,
    required this.isFirstItem,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = hourlyWeather?.timestamp ?? DateTime.now();
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
          color: isFirstItem ? ColorConstant.link50 : null,
        ),
        child: Column(
          children: [
            WeatherDateTimeWidget(
              dateTime: formattedTime,
              textStyle: TextStyleConstant.caption,
            ),
            const SizedBox(
              height: 8,
            ),
            WeatherImageWidget(
              description: hourlyWeather?.description.toString(),
            ),
            const SizedBox(
              height: 8,
            ),
            WeatherTemperatureWidget(
              temperature: hourlyWeather?.temperature,
            ),
          ],
        ),
      ),
    );
  }
}
