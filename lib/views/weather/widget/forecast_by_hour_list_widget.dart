import 'package:flutter/material.dart';
import 'package:plantopia/models/get_forecast_by_hour_response_model.dart';
import 'package:plantopia/views/weather/widget/forecast_by_hour_list_item_widget.dart';

class ForecastByHourListWidget extends StatelessWidget {
  final GetForecastByHourResponseModel forecastByHourModel;
  const ForecastByHourListWidget({
    super.key,
    required this.forecastByHourModel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 94,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: forecastByHourModel.list?.length ?? 0,
        itemBuilder: (context, index) {
          final forecastByHourModelItem = forecastByHourModel.list?[index];
          final isFirstItem = index == 0;
          return ForecastByHourListItemWidget(
            forecastByHourListElement: forecastByHourModelItem ?? ListElement(),
            isFirstItem: isFirstItem,
          );
        },
      ),
    );
  }
}
