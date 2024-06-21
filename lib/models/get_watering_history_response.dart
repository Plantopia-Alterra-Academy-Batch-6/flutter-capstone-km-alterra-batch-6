// To parse this JSON data, do
//
//     final getWateringHistoryResponse = getWateringHistoryResponseFromJson(jsonString);

import 'dart:convert';

GetWateringHistoryResponse getWateringHistoryResponseFromJson(String str) =>
    GetWateringHistoryResponse.fromJson(json.decode(str));

String getWateringHistoryResponseToJson(GetWateringHistoryResponse data) =>
    json.encode(data.toJson());

class GetWateringHistoryResponse {
  String? status;
  String? message;
  List<WateringHistory>? data;

  GetWateringHistoryResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetWateringHistoryResponse.fromJson(Map<String, dynamic> json) =>
      GetWateringHistoryResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<WateringHistory>.from(
                json["data"]!.map((x) => WateringHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WateringHistory {
  int? id;
  Plant? plant;
  User? user;
  DateTime? createdAt;

  WateringHistory({
    this.id,
    this.plant,
    this.user,
    this.createdAt,
  });

  factory WateringHistory.fromJson(Map<String, dynamic> json) =>
      WateringHistory(
        id: json["id"],
        plant: json["plant"] == null ? null : Plant.fromJson(json["plant"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant": plant?.toJson(),
        "user": user?.toJson(),
        "created_at": createdAt?.toIso8601String(),
      };
}

class Plant {
  int? id;
  String? name;
  String? description;
  bool? isToxic;
  int? harvestDuration;
  String? sunlight;
  String? plantingTime;
  String? climateCondition;
  List<PlantImage>? plantImage;
  DateTime? createdAt;

  Plant({
    this.id,
    this.name,
    this.description,
    this.isToxic,
    this.harvestDuration,
    this.sunlight,
    this.plantingTime,
    this.climateCondition,
    this.plantImage,
    this.createdAt,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isToxic: json["is_toxic"],
        harvestDuration: json["harvest_duration"],
        sunlight: json["sunlight"],
        plantingTime: json["planting_time"],
        climateCondition: json["climate_condition"],
        plantImage: json["plant_image"] == null
            ? []
            : List<PlantImage>.from(
                json["plant_image"]!.map((x) => PlantImage.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "is_toxic": isToxic,
        "harvest_duration": harvestDuration,
        "sunlight": sunlight,
        "planting_time": plantingTime,
        "climate_condition": climateCondition,
        "plant_image": plantImage == null
            ? []
            : List<dynamic>.from(plantImage!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
      };
}

class PlantImage {
  int? id;
  String? fileName;

  PlantImage({
    this.id,
    this.fileName,
  });

  factory PlantImage.fromJson(Map<String, dynamic> json) => PlantImage(
        id: json["id"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_name": fileName,
      };
}

class User {
  int? id;
  String? name;
  String? email;
  bool? isActive;
  String? otp;
  String? urlImage;
  String? fcmToken;
  DateTime? createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.isActive,
    this.otp,
    this.urlImage,
    this.fcmToken,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        isActive: json["is_active"],
        otp: json["otp"],
        urlImage: json["url_image"],
        fcmToken: json["fcm_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "is_active": isActive,
        "otp": otp,
        "url_image": urlImage,
        "fcm_token": fcmToken,
        "created_at": createdAt?.toIso8601String(),
      };
}
