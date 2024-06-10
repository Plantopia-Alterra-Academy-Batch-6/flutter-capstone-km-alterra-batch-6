part of 'forecast_by_hour_list_widget.dart';

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
