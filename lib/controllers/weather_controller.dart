import 'package:get/get.dart';
import 'package:plantopia/helpers/shared_pref_helper.dart';
import 'package:plantopia/models/get_current_weather_response_model.dart';
import 'package:plantopia/models/get_forecast_by_day_response_model.dart';
import 'package:plantopia/models/get_forecast_by_hour_response_model.dart';
import 'package:plantopia/service/weather_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

// TODO: Error handling
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
  RxBool locationPermissionGranted = false.obs;
  Rx<Position?> userLocation = Rx<Position?>(null);
  RxBool locationPermissionDenied = false.obs;

  void initLocationAndWeatherData() async {
    await requestLocationPermission();
    if (locationPermissionGranted.value) {
      await getUserLocationAndWeather();
    } else {
      _setErrorStatus();
    }
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    locationPermissionGranted.value = status.isGranted;
    locationPermissionDenied.value = !status.isGranted;
  }

  Future<void> getUserLocationAndWeather() async {
    if (await Geolocator.isLocationServiceEnabled()) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        userLocation.value = position;
        SharedPrefHelper.saveUserLocation(position.latitude, position.longitude);
        await getWeatherData(position.latitude, position.longitude);
      } catch (e) {
        _setErrorStatus();
      }
    } else {
      _setErrorStatus();
    }
  }

  Future<void> getWeatherData(double lat, double lon) async {
    currentWeatherStatus.value = Status.loading;
    forecastByHour.value = Status.loading;
    forecastByDay.value = Status.loading;
    await Future.wait([
      getCurrentWeatherData(lat, lon),
      getForecastByHourData(lat, lon),
      getForecastByDayData(lat, lon),
    ]);
  }

  Future<void> getCurrentWeatherData(double lat, double lon) async {
    try {
      final response = await WeatherService().getCurrentWeather(lat: lat, lon: lon);
      weatherData.value = response;
      currentWeatherStatus.value = Status.loaded;
    } catch (e) {
      currentWeatherStatus.value = Status.error;
    }
  }

  Future<void> getForecastByHourData(double lat, double lon) async {
    try {
      final response = await WeatherService().getForecastByHour(lat: lat, lon: lon);
      forecastByHourData.value = response;
      forecastByHour.value = Status.loaded;
    } catch (e) {
      forecastByHour.value = Status.error;
    }
  }

  Future<void> getForecastByDayData(double lat, double lon) async {
    try {
      final response = await WeatherService().getForcastByDay(lat: lat, lon: lon);
      forecastByDayData.value = response;
      forecastByDay.value = Status.loaded;
    } catch (e) {
      forecastByDay.value = Status.error;
    }
  }

  void _setErrorStatus() {
    currentWeatherStatus.value = Status.error;
    forecastByHour.value = Status.error;
    forecastByDay.value = Status.error;
  }
}