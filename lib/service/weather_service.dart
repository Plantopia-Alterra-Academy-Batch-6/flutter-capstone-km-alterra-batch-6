import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plantopia/models/get_current_weather_response_model.dart';
import 'package:plantopia/models/get_forecast_by_day_response_model.dart';
import 'package:plantopia/models/get_forecast_by_hour_response_model.dart';
import 'package:plantopia/utils/base_url_util.dart';

class WeatherService {
  final Dio dio = Dio();
  final String apiKey = "5abe71406c0f4135dea0f76a724f8b92";

  Future<GetCurrentWeatherResponseModel> getCurrentWeather(
      {double? lat, double? lon}) async {
    try {
      String url =
          '${BaseUrlUtil.baseUrl}/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return GetCurrentWeatherResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load weather: $e');
    }
  }

  Future<GetForecastByHourResponseModel> getForecastByHour(
      {double? lat, double? lon}) async {
    try {
      String url =
          '${BaseUrlUtil.baseUrl}/forecast/hourly?lat=$lat&lon=$lon&appid=$apiKey&units=metric&cnt=24';
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return GetForecastByHourResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load weather: $e');
    }
  }

  Future<GetForecastByDayResponseModel> getForcastByDay(
      {double? lat, double? lon}) async {
    try {
      String url =
          '${BaseUrlUtil.baseUrl}/forecast/climate?lat=$lat&lon=$lon&appid=$apiKey&units=metric&cnt=7';
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return GetForecastByDayResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load weather: $e');
    }
  }
}
