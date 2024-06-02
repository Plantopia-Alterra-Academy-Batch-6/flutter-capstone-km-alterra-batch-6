import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/home_controller.dart';
import 'package:plantopia/helpers/shared_pref_helper.dart';
import 'package:plantopia/models/get_current_weather_response_model.dart';
import 'package:plantopia/models/get_forecast_by_day_response_model.dart';
import 'package:plantopia/models/get_forecast_by_hour_response_model.dart';
import 'package:plantopia/service/weather_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class WeatherController extends GetxController {
  Rx<Status> currentWeatherStatus = Status.loading.obs;
  Rx<Status> forecastByHour = Status.loading.obs;
  Rx<Status> forecastByDay = Status.loading.obs;
  Rx<GetCurrentWeatherResponseModel> weatherData =
      GetCurrentWeatherResponseModel().obs;
  Rx<GetForecastByHourResponseModel> forecastByHourData =
      GetForecastByHourResponseModel().obs;
  Rx<GetForecastByDayResponseModel> forecastByDayData =
      GetForecastByDayResponseModel().obs;

  @override
  void onInit() {
    super.onInit();
    HomeController homeController = Get.find<HomeController>();
    ever(homeController.locationPermissionGranted, (permissionGranted) async {
      if (permissionGranted) {
        double? savedLatitude = await SharedPrefHelper.getUserLatitude();
        double? savedLongitude = await SharedPrefHelper.getUserLongitude();

        if (kDebugMode) {
          print("Latitude: $savedLatitude, Longitude: $savedLongitude");
        }

        if (savedLatitude != null && savedLongitude != null) {
          await getWeatherData(savedLatitude, savedLongitude);
        } else {
          if (kDebugMode) {
            print(
                "Error: Latitude or Longitude is null. Retrying in 3 seconds...");
          }
          await Future.delayed(const Duration(seconds: 3));
          double? retryLatitude = await SharedPrefHelper.getUserLatitude();
          double? retryLongitude = await SharedPrefHelper.getUserLongitude();

          if (retryLatitude != null && retryLongitude != null) {
            await getWeatherData(retryLatitude, retryLongitude);
          } else {
            if (kDebugMode) {
              print(
                  "Error: Latitude or Longitude is still null after retrying.");
            }
          }
        }
      }
    });
  }

  Future<void> getWeatherData(double lat, double lon) async {
    if (kDebugMode) {
      print("Starting getWeatherData");
    }

    getCurrentWeatherData(lat, lon);

    if (kDebugMode) {
      print(
          "Called getCurrentWeatherData with Latitude = $lat, Longitude = $lon");
    }

    getForecastByHourData(lat, lon);

    if (kDebugMode) {
      print(
          "Called getForecastByHourData with Latitude = $lat, Longitude = $lon");
    }

    getForecastByDayData(lat, lon);

    if (kDebugMode) {
      print(
          "Called getForecastByDayData with Latitude = $lat, Longitude = $lon");
    }

    if (kDebugMode) {
      print("Finished getWeatherData");
    }
  }

  void getCurrentWeatherData(double lat, double lon) async {
    try {
      currentWeatherStatus.value = Status.loading;
      final response =
          await WeatherService().getCurrentWeather(lat: lat, lon: lon);
      weatherData.value = response;
      currentWeatherStatus.value = Status.loaded;
    } catch (e) {
      currentWeatherStatus.value = Status.error;
    }
  }

  void getForecastByHourData(double lat, double lon) async {
    try {
      forecastByHour.value = Status.loading;
      final response =
          await WeatherService().getForecastByHour(lat: lat, lon: lon);
      forecastByHourData.value = response;
      forecastByHour.value = Status.loaded;
    } catch (e) {
      forecastByHour.value = Status.error;
      if (kDebugMode) {
        print("Error in getForecastByHourData: $e");
      }
    }
  }

  void getForecastByDayData(double lat, double lon) async {
    try {
      forecastByDay.value = Status.loading;
      final response =
          await WeatherService().getForcastByDay(lat: lat, lon: lon);
      forecastByDayData.value = response;
      forecastByDay.value = Status.loaded;
    } catch (e) {
      forecastByDay.value = Status.error;
      if (kDebugMode) {
        print("Error in getForecastByDayData: $e");
      }
    }
  }
}
