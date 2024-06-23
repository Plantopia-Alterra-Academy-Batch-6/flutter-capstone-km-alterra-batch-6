import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_current_weather_response_model.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WeatherInfoRealFeelWidget extends StatelessWidget {
  final GetCurrentWeatherResponseModel weatherData;
  const WeatherInfoRealFeelWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final double feelsLike = weatherData.data?.realFeel?.toDouble() ?? 0.0;

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
              child: Text('Real Feel',
                  style: TextStyleConstant.caption
                      .copyWith(color: ColorConstant.neutral500)),
            ),
            Positioned(
              top: 32,
              left: 16,
              child: Text('${feelsLike.toInt()}°',
                  style: TextStyleConstant.title.copyWith(
                    fontWeight: FontWeight.w700,
                  )),
            ),
            Positioned(
              right: 16.0,
              bottom: 12.0,
              child: SizedBox(
                width: 64,
                height: 64,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      showLabels: false,
                      showTicks: false,
                      maximum: 100,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 6,
                      ),
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 0,
                          endValue: 50,
                          color: ColorConstant.link500,
                          startWidth: 6,
                          endWidth: 6,
                        ),
                        GaugeRange(
                          startValue: 50,
                          endValue: 70,
                          color: ColorConstant.primary500,
                          startWidth: 6,
                          endWidth: 6,
                        ),
                        GaugeRange(
                          startValue: 70,
                          endValue: 100,
                          color: ColorConstant.warning500,
                          startWidth: 6,
                          endWidth: 6,
                        ),
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: feelsLike,
                          needleColor: ColorConstant.neutral950,
                          needleLength: 0.6,
                          needleStartWidth: 0.5,
                          needleEndWidth: 2,
                          knobStyle: KnobStyle(
                            knobRadius: 0.12,
                            borderColor: ColorConstant.neutral950,
                            borderWidth: 0.02,
                            color: ColorConstant.white,
                          ),
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
