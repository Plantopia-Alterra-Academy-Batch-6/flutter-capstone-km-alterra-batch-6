// To parse this JSON data, do
//
//     final getDailyWeatherResponseModel = getDailyWeatherResponseModelFromJson(jsonString);

import 'dart:convert';

GetDailyWeatherResponseModel getDailyWeatherResponseModelFromJson(String str) => GetDailyWeatherResponseModel.fromJson(json.decode(str));

String getDailyWeatherResponseModelToJson(GetDailyWeatherResponseModel data) => json.encode(data.toJson());

class GetDailyWeatherResponseModel {
    final String? message;
    final int? code;
    final String? status;
    final List<DailyWeather>? data;

    GetDailyWeatherResponseModel({
        this.message,
        this.code,
        this.status,
        this.data,
    });

    factory GetDailyWeatherResponseModel.fromJson(Map<String, dynamic> json) => GetDailyWeatherResponseModel(
        message: json["message"],
        code: json["code"],
        status: json["status"],
        data: json["data"] == null ? [] : List<DailyWeather>.from(json["data"]!.map((x) => DailyWeather.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DailyWeather {
    final int? id;
    final String? city;
    final double? temperature;
    final double? realFeel;
    final int? pressure;
    final int? humidity;
    final double? windSpeed;
    final String? main;
    final String? description;
    final int? sunrise;
    final String? icon;
    final DateTime? date;

    DailyWeather({
        this.id,
        this.city,
        this.temperature,
        this.realFeel,
        this.pressure,
        this.humidity,
        this.windSpeed,
        this.main,
        this.description,
        this.sunrise,
        this.icon,
        this.date,
    });

    factory DailyWeather.fromJson(Map<String, dynamic> json) => DailyWeather(
        id: json["id"],
        city: json["city"],
        temperature: json["temperature"]?.toDouble(),
        realFeel: json["real_feel"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        windSpeed: json["wind_speed"]?.toDouble(),
        main: json["main"],
        description: json["description"],
        sunrise: json["sunrise"],
        icon: json["icon"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
        "sunrise": sunrise,
        "icon": icon,
        "date": date?.toIso8601String(),
    };
}
