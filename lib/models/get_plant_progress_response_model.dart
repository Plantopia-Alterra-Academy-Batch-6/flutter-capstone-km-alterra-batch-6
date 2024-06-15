// To parse this JSON data, do
//
//     final getPlantProgressResponseModel = getPlantProgressResponseModelFromJson(jsonString);

import 'dart:convert';

GetPlantProgressResponseModel getPlantProgressResponseModelFromJson(
        String str) =>
    GetPlantProgressResponseModel.fromJson(json.decode(str));

String getPlantProgressResponseModelToJson(
        GetPlantProgressResponseModel data) =>
    json.encode(data.toJson());

class GetPlantProgressResponseModel {
  final String? message;
  final int? code;
  final String? status;
  final Data? data;

  GetPlantProgressResponseModel({
    this.message,
    this.code,
    this.status,
    this.data,
  });

  factory GetPlantProgressResponseModel.fromJson(Map<String, dynamic> json) =>
      GetPlantProgressResponseModel(
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
  final List<PlantProgress>? plantProgress;

  Data({
    this.plantProgress,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        plantProgress: json["plant_progress"] == null
            ? []
            : List<PlantProgress>.from(
                json["plant_progress"]!.map((x) => PlantProgress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "plant_progress": plantProgress == null
            ? []
            : List<dynamic>.from(plantProgress!.map((x) => x.toJson())),
      };
}

class PlantProgress {
  final int? id;
  final int? plantId;
  final int? userId;
  final String? imageUrl;
  final DateTime? createdAt;

  PlantProgress({
    this.id,
    this.plantId,
    this.userId,
    this.imageUrl,
    this.createdAt,
  });

  factory PlantProgress.fromJson(Map<String, dynamic> json) => PlantProgress(
        id: json["id"],
        plantId: json["plant_id"],
        userId: json["user_id"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "user_id": userId,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
      };
}
