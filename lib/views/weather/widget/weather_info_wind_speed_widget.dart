import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_current_weather_response_model.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WeatherInfoWindSpeedWidget extends StatelessWidget {
  final GetCurrentWeatherResponseModel weatherData;
  const WeatherInfoWindSpeedWidget({super.key, required this.weatherData});

  @override
  Widget build(BuildContext context) {
    final double windSpeed = weatherData.wind?.speed ?? 0.0;

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
                  'Wind Speed',
                  style: TextStyleConstant.caption.copyWith(color:ColorConstant.neutral500 )
                ),
                
              ),
              
              Positioned(
                top: 32,
                left: 16,
                child: Text(
                  windSpeed.toString(),
                  style: TextStyleConstant.title.copyWith(fontWeight: FontWeight.w700,)
                  
                ),
              ),
              Positioned(
                top: 74,
                left: 95,
                child: SvgPicture.asset(
                  IconConstant.wind,
                  width: 24,
                  height: 24,
                ),
              ),
              Positioned(
                right: 16.0,
                bottom: 12.0,
                child: Container(
                  width: 64,
                  height: 64,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        showLabels: false,
                        showTicks: false,
                        maximum: 10.0,
                        axisLineStyle: const AxisLineStyle(
                          thickness: 6,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: windSpeed,
                            cornerStyle: CornerStyle.bothCurve,
                            color: ColorConstant.primary500,
                            width: 6.0,
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
