import 'package:get/get.dart';
import 'package:plantopia/helpers/shared_pref_helper.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/models/get_current_weather_response_model.dart';
import 'package:plantopia/models/get_daily_weather_response_model.dart';
import 'package:plantopia/models/get_hourly_weather_response_model.dart';
import 'package:plantopia/service/weather_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class WeatherController extends GetxController {
  Rx<Status> currentWeatherStatus = Status.loading.obs;
  Rx<Status> hourlyWeather = Status.loading.obs;
  Rx<Status> dailyWeather = Status.loading.obs;
  Rx<GetCurrentWeatherResponseModel> weatherData =
      GetCurrentWeatherResponseModel().obs;
  Rx<GetHourlyWeatherResponseModel> hourlyWeatherData =
      GetHourlyWeatherResponseModel().obs;
  Rx<GetDailyWeatherResponseModel> dailyWeatherData =
      GetDailyWeatherResponseModel().obs;
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
        SharedPrefHelper.saveUserLocation(
            position.latitude, position.longitude);
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
    hourlyWeather.value = Status.loading;
    dailyWeather.value = Status.loading;
    await Future.wait([
      getCurrentWeatherData(lat, lon),
      getHourlyWeatherData(lat, lon),
      getDailyWeatherData(lat, lon),
    ]);
  }

  Future<void> getCurrentWeatherData(double lat, double lon) async {
    try {
      final token = await UserTokenPref.getToken();

      final response = await WeatherService()
          .getCurrentWeather(token: token, lat: lat, lon: lon);
      weatherData.value = response;
      currentWeatherStatus.value = Status.loaded;
    } catch (e) {
      currentWeatherStatus.value = Status.error;
    }
  }

  Future<void> getHourlyWeatherData(double lat, double lon) async {
    try {
      final token = await UserTokenPref.getToken();

      final response = await WeatherService()
          .getHourlyWeather(token: token, lat: lat, lon: lon);
      hourlyWeatherData.value = response;
      hourlyWeather.value = Status.loaded;
    } catch (e) {
      hourlyWeather.value = Status.error;
    }
  }

  Future<void> getDailyWeatherData(double lat, double lon) async {
    try {
      final token = await UserTokenPref.getToken();

      final response = await WeatherService()
          .getDailyWeather(token: token, lat: lat, lon: lon);
      dailyWeatherData.value = response;
      dailyWeather.value = Status.loaded;
    } catch (e) {
      dailyWeather.value = Status.error;
    }
  }



  void _setErrorStatus() {
    currentWeatherStatus.value = Status.error;
    hourlyWeather.value = Status.error;
    dailyWeather.value = Status.error;
  }
}
