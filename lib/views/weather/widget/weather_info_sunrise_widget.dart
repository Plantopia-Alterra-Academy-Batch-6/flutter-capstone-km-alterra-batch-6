import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_current_weather_response_model.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WeatherInfoSunsetSunriseWidget extends StatelessWidget {
  final GetCurrentWeatherResponseModel weatherData;

  const WeatherInfoSunsetSunriseWidget({
    super.key,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    final int? sunrise = weatherData.data?.sunrise;
    final int? sunset = weatherData.data?.sunrise;

    if (sunrise == null || sunset == null) {
      return const Text("Data not available");
    }

    final currentTime = DateTime.now();
    final isSunrise = currentTime
            .isBefore(DateTime.fromMillisecondsSinceEpoch(sunset * 1000)) &&
        currentTime
            .isAfter(DateTime.fromMillisecondsSinceEpoch(sunrise * 1000));
    final sunriseOrSunsetText = isSunrise ? "Sunrise" : "Sunset";
    final formattedTime = DateFormat.Hm().format(currentTime);

    final sunriseDateTime = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    final sunsetDateTime = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
    final totalDuration = sunsetDateTime.difference(sunriseDateTime).inSeconds;
    final elapsedDuration = currentTime.difference(sunriseDateTime).inSeconds;
    final percentage = (elapsedDuration / totalDuration) * 100;

    return Center(
      child: Container(
        width: 156,
        height: 130,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorConstant.neutral300,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 15,
              left: 16,
              child: Text(
                sunriseOrSunsetText,
                style: TextStyleConstant.caption
                    .copyWith(color: ColorConstant.neutral500),
              ),
            ),
            Positioned(
              top: 32,
              left: 16,
              child: Text(
                formattedTime,
                style: TextStyleConstant.title
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Positioned(
              right: 16.0,
              bottom: 25.0,
              child: SizedBox(
                width: 94,
                height: 64,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      startAngle: 180,
                      endAngle: 0,
                      centerX: 0.5,
                      centerY: 1.0,
                      showLabels: false,
                      showTicks: false,
                      maximum: 100,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 6,
                      ),
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 0,
                          endValue: 100,
                          gradient: SweepGradient(
                            colors: <Color>[
                              ColorConstant.warning100,
                              ColorConstant.warning500
                            ],
                            stops: const <double>[0.25, 0.75],
                          ),
                          startWidth: 6,
                          endWidth: 6,
                        ),
                      ],
                      pointers: <GaugePointer>[
                        MarkerPointer(
                          value: percentage,
                          markerHeight: 7,
                          markerWidth: 7,
                          markerType: MarkerType.circle,
                          color: ColorConstant.warning500,
                          borderWidth: 1,
                          borderColor: ColorConstant.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
