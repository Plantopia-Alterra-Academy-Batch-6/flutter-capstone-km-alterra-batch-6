// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:plantopia/controllers/weather_controller.dart';
// import 'package:plantopia/models/get_current_weather_response_model.dart';
// import 'package:plantopia/utils/status_enum_util.dart';
// import 'package:plantopia/views/weather/widget/current_weather_date_widget.dart';
// import 'package:plantopia/views/weather/widget/current_weather_temperature_widget.dart';
// import 'package:plantopia/views/weather/widget/forecast_by_hour_image_widget.dart';

// // For List Today's Weather
// class CurrentWeatherListItemWigdet extends StatelessWidget {
//   final WeatherController weatherController = Get.put(WeatherController());
//   CurrentWeatherListItemWigdet({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         switch (weatherController.currentWeatherStatus.value) {
//           case Status.loading:
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           case Status.loaded:
//             return Padding(
//               padding: const EdgeInsets.only(right: 16),
//               child: Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16.5,
//                   vertical: 8,
//                 ),
//                 child: Column(
//                   children: [
//                     CurrentWeatherDateWidget(
//                       currentDate: weatherController.weatherData.value.dt,
//                     ),
//                     ForecastByHourImageWidget(
//                       description: weatherController
//                           .weatherData.value.weather?.first.description,
//                     ),
//                     CurrentWeatherTemperatureWidget(
//                       temperature:
//                           weatherController.weatherData.value.main?.temp,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           case Status.error:
//             return const Center(
//               child: Text(
//                 "Failed to load current weather data. Please try again later.",
//                 style: TextStyle(fontSize: 18, color: Colors.red),
//               ),
//             );
//           default:
//             return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
