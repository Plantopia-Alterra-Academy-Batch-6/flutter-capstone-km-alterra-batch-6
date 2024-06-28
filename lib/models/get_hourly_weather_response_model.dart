
import 'dart:convert';

GetHourlyWeatherResponseModel getHourlyWeatherResponseModelFromJson(
        String str) =>
    GetHourlyWeatherResponseModel.fromJson(json.decode(str));

String getHourlyWeatherResponseModelToJson(
        GetHourlyWeatherResponseModel data) =>
    json.encode(data.toJson());

class GetHourlyWeatherResponseModel {
  final String? message;
  final int? code;
  final String? status;
  final List<HourlyWeather>? data;

  GetHourlyWeatherResponseModel({
    this.message,
    this.code,
    this.status,
    this.data,
  });

  factory GetHourlyWeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      GetHourlyWeatherResponseModel(
        message: json["message"],
        code: json["code"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<HourlyWeather>.from(
                json["data"]!.map((x) => HourlyWeather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HourlyWeather {
  final int? id;
  final String? city;
  final double? temperature;
  final double? realFeel;
  final int? pressure;
  final int? humidity;
  final double? windSpeed;
  final String? main;
  final String? description;
  final String? icon;
  final DateTime? timestamp;

  HourlyWeather({
    this.id,
    this.city,
    this.temperature,
    this.realFeel,
    this.pressure,
    this.humidity,
    this.windSpeed,
    this.main,
    this.description,
    this.icon,
    this.timestamp,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) => HourlyWeather(
        id: json["id"],
        city: json["city"],
        temperature: json["temperature"]?.toDouble(),
        realFeel: json["real_feel"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        windSpeed: json["wind_speed"]?.toDouble(),
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "temperature": temperature,
        "real_feel": realFeel,
        "pressure": pressure,
        "humidity": humidity,
        "wind_speed": windSpeed,
        "main": main,
        "description": description,
        "icon": icon,
        "timestamp": timestamp?.toIso8601String(),
      };
}
