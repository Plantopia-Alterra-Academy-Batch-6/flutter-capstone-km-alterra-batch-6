

import 'dart:convert';

GetLaterWateringResponse getLaterWateringResponseFromJson(String str) =>
    GetLaterWateringResponse.fromJson(json.decode(str));

String getLaterWateringResponseToJson(GetLaterWateringResponse data) =>
    json.encode(data.toJson());

class GetLaterWateringResponse {
  String? status;
  String? message;
  Data? data;

  GetLaterWateringResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetLaterWateringResponse.fromJson(Map<String, dynamic> json) =>
      GetLaterWateringResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  int? id;
  String? title;
  String? body;
  int? userId;
  Plant? plant;
  DateTime? createdAt;

  Data({
    this.id,
    this.title,
    this.body,
    this.userId,
    this.plant,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userId: json["user_id"],
        plant: json["plant"] == null ? null : Plant.fromJson(json["plant"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "user_id": userId,
        "plant": plant?.toJson(),
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
