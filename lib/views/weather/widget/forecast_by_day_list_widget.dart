import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_forecast_by_day_response_model.dart';
import 'package:plantopia/views/weather/widget/weather_date_time_widget.dart';
import 'package:plantopia/views/weather/widget/weather_image_widget.dart';
import 'package:plantopia/views/weather/widget/weather_temperature_widget.dart';
import 'package:intl/intl.dart';


part 'forecast_by_day_list_item_widget.dart';

class ForecastByDayListWidget extends StatelessWidget {
  final GetForecastByDayResponseModel forecastByDayModel;
  const ForecastByDayListWidget({
    super.key,
    required this.forecastByDayModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: forecastByDayModel.list?.length ?? 0,
        itemBuilder: (context, index) {
          final forecastByDayModelItem = forecastByDayModel.list?[index];
          return ForecastByDayListItemWidget(
            forecastByDayListElement: forecastByDayModelItem ?? ListElement(),
          );
        },
      ),
    );
  }
}
