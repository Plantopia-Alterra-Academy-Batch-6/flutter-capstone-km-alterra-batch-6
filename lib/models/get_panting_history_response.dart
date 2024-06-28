

import 'dart:convert';

GetPlantingHistoryResponse getPlantingHistoryResponseFromJson(String str) =>
    GetPlantingHistoryResponse.fromJson(json.decode(str));

String getPlantingHistoryResponseToJson(GetPlantingHistoryResponse data) =>
    json.encode(data.toJson());

class GetPlantingHistoryResponse {
  String? message;
  int? code;
  String? status;
  List<PlantHistory>? data;

  GetPlantingHistoryResponse({
    this.message,
    this.code,
    this.status,
    this.data,
  });

  factory GetPlantingHistoryResponse.fromJson(Map<String, dynamic> json) =>
      GetPlantingHistoryResponse(
        message: json["message"],
        code: json["code"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<PlantHistory>.from(
                json["data"]!.map((x) => PlantHistory.fromJson(x))),
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

class PlantHistory {
  int? id;
  int? userId;
  String? plantName;
  String? plantCategory;
  String? imageUrl;
  DateTime? createdAt;

  PlantHistory({
    this.id,
    this.userId,
    this.plantName,
    this.plantCategory,
    this.imageUrl,
    this.createdAt,
  });

  factory PlantHistory.fromJson(Map<String, dynamic> json) => PlantHistory(
        id: json["id"],
        userId: json["user_id"],
        plantName: json["plant_name"],
        plantCategory: json["plant_category"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "plant_name": plantName,
        "plant_category": plantCategory,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
      };
}
