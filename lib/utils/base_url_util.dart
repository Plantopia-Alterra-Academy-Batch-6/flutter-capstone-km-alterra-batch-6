class BaseUrlUtil {
  static const String baseUrl =
      'https://be-agriculture-awh2j5ffyq-uc.a.run.app/api/v1';
  static const String currentWeatherUrl = '$baseUrl/weather/current';
  static const String hourlyWeather = '$baseUrl/weather/hourly';
  static const String dailyWeather = '$baseUrl/weather/daily';
  static const String plantGuide = '$baseUrl/plants';
  static const String plantDisease = '$baseUrl/plant-disease';
  static const String plantInstruction = '$baseUrl/plants/instructions';
  static const String plantByUserId = '$baseUrl/my/plants';
}