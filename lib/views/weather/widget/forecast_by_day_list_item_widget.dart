part of 'forecast_by_day_list_widget.dart';

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
    String formattedDay = DateFormat('EEEE').format(dateTime);
    String formattedDate = DateFormat('dd MMMM').format(dateTime);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeatherDateTimeWidget(
                  dateTime: formattedDay,
                  textStyle: TextStyleConstant.paragraph.copyWith(
                    color: ColorConstant.neutral500,
                  ),
                ),
                WeatherDateTimeWidget(
                  dateTime: formattedDate,
                  textStyle: TextStyleConstant.subtitle.copyWith(
                      color: ColorConstant.neutral950,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          WeatherTemperatureWidget(
            temperature: forecastByDayListElement.temp?.day,
            textStyle: TextStyleConstant.heading1.copyWith(
              fontWeight: FontWeight.w700,
            ),
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
