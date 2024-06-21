// To parse this JSON data, do
//
//     final getCurrentWeatherResponseModel = getCurrentWeatherResponseModelFromJson(jsonString);

import 'dart:convert';

GetCurrentWeatherResponseModel getCurrentWeatherResponseModelFromJson(
        String str) =>
    GetCurrentWeatherResponseModel.fromJson(json.decode(str));

String getCurrentWeatherResponseModelToJson(
        GetCurrentWeatherResponseModel data) =>
    json.encode(data.toJson());

class GetCurrentWeatherResponseModel {
  final String? message;
  final int? code;
  final String? status;
  final Data? data;

  GetCurrentWeatherResponseModel({
    this.message,
    this.code,
    this.status,
    this.data,
  });

  factory GetCurrentWeatherResponseModel.fromJson(Map<String, dynamic> json) =>
      GetCurrentWeatherResponseModel(
        message: json["message"],
        code: json["code"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
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
  final int? sunrise;
  final DateTime? createdAt;

  Data({
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
    this.sunrise,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        sunrise: json["sunrise"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
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
        "sunrise": sunrise,
        "created_at": createdAt?.toIso8601String(),
      };
}
