// ignore_for_file: constant_identifier_names

import 'dart:convert';

GetForecastByDayResponseModel getForecastByDayResponseModelFromJson(
        String str) =>
    GetForecastByDayResponseModel.fromJson(json.decode(str));

String getForecastByDayResponseModelToJson(
        GetForecastByDayResponseModel data) =>
    json.encode(data.toJson());

class GetForecastByDayResponseModel {
  final City? city;
  final String? code;
  final double? message;
  final int? cnt;
  final List<ListElement>? list;

  GetForecastByDayResponseModel({
    this.city,
    this.code,
    this.message,
    this.cnt,
    this.list,
  });

  factory GetForecastByDayResponseModel.fromJson(Map<String, dynamic> json) =>
      GetForecastByDayResponseModel(
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        code: json["code"],
        message: json["message"]?.toDouble(),
        cnt: json["cnt"],
        list: json["list"] == null
            ? []
            : List<ListElement>.from(
                json["list"]!.map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "city": city?.toJson(),
        "code": code,
        "message": message,
        "cnt": cnt,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class City {
  final int? id;
  final String? name;
  final Coord? coord;
  final String? country;
  final int? population;
  final int? timezone;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
        country: json["country"],
        population: json["population"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord?.toJson(),
        "country": country,
        "population": population,
        "timezone": timezone,
      };
}

class Coord {
  final double? lon;
  final double? lat;

  Coord({
    this.lon,
    this.lat,
  });

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

class ListElement {
  final int? dt;
  final int? sunrise;
  final int? sunset;
  final Temp? temp;
  final FeelsLike? feelsLike;
  final int? pressure;
  final int? humidity;
  final List<Weather>? weather;
  final double? speed;
  final int? deg;
  final int? clouds;
  final double? rain;

  ListElement({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.weather,
    this.speed,
    this.deg,
    this.clouds,
    this.rain,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"] == null ? null : Temp.fromJson(json["temp"]),
        feelsLike: json["feels_like"] == null
            ? null
            : FeelsLike.fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        weather: json["weather"] == null
            ? []
            : List<Weather>.from(
                json["weather"]!.map((x) => Weather.fromJson(x))),
        speed: json["speed"]?.toDouble(),
        deg: json["deg"],
        clouds: json["clouds"],
        rain: json["rain"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp?.toJson(),
        "feels_like": feelsLike?.toJson(),
        "pressure": pressure,
        "humidity": humidity,
        "weather": weather == null
            ? []
            : List<dynamic>.from(weather!.map((x) => x.toJson())),
        "speed": speed,
        "deg": deg,
        "clouds": clouds,
        "rain": rain,
      };
}

class FeelsLike {
  final double? day;
  final double? night;
  final double? eve;
  final double? morn;

  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn,
  });

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}

class Temp {
  final double? day;
  final double? min;
  final double? max;
  final double? night;
  final double? eve;
  final double? morn;

  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"]?.toDouble(),
        min: json["min"]?.toDouble(),
        max: json["max"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "min": min,
        "max": max,
        "night": night,
        "eve": eve,
        "morn": morn,
      };
}

class Weather {
  final int? id;
  final Main? main;
  final Description? description;
  final Icon? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: mainValues.map[json["main"]]!,
        description: descriptionValues.map[json["description"]]!,
        icon: iconValues.map[json["icon"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": mainValues.reverse[main],
        "description": descriptionValues.reverse[description],
        "icon": iconValues.reverse[icon],
      };
}

enum Description { LIGHT_RAIN, MODERATE_RAIN }

final descriptionValues = EnumValues({
  "light rain": Description.LIGHT_RAIN,
  "moderate rain": Description.MODERATE_RAIN
});

enum Icon { THE_10_D }

final iconValues = EnumValues({"10d": Icon.THE_10_D});

enum Main { RAIN }

final mainValues = EnumValues({"Rain": Main.RAIN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
