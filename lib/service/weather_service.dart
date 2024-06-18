import 'package:dio/dio.dart';
import 'package:plantopia/models/get_current_weather_response_model.dart';
import 'package:plantopia/models/get_daily_weather_response_model.dart';
import 'package:plantopia/models/get_hourly_weather_response_model.dart';
import 'package:plantopia/utils/base_url_util.dart';

class WeatherService {
  final Dio dio = Dio();
  Future<GetCurrentWeatherResponseModel> getCurrentWeather(
      {String? token, double? lat, double? lon}) async {
    try {
      String url = '${BaseUrlUtil.currentWeatherUrl}?lat=$lat&lon=$lon';
      Options options = Options(headers: {'Authorization': 'Bearer $token'});
      final response = await dio.get(url, options: options);
      if (response.statusCode == 200) {
        return GetCurrentWeatherResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
      
    } catch (e) {
      throw Exception('Failed to load weather: $e');
    }
  }

  Future<GetHourlyWeatherResponseModel> getHourlyWeather(
      {String? token, double? lat, double? lon}) async {
    try {
      String url = '${BaseUrlUtil.hourlyWeather}?lat=$lat&lon=$lon';
      Options options = Options(headers: {'Authorization': 'Bearer $token'});
      final response = await dio.get(url, options: options);
      if (response.statusCode == 200) {
        return GetHourlyWeatherResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load weather: $e');
    }
  }

  Future<GetDailyWeatherResponseModel> getDailyWeather(
      {String? token, double? lat, double? lon}) async {
    try {
      String url = '${BaseUrlUtil.dailyWeather}?lat=$lat&lon=$lon';
      Options options = Options(headers: {'Authorization': 'Bearer $token'});

      final response = await dio.get(url, options: options);
      if (response.statusCode == 200) {
        return GetDailyWeatherResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load weather: $e');
    }
  }
}
