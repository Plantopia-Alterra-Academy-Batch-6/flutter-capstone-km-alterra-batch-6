

import 'dart:convert';

GetMyPlantResponseModelNew getMyPlantResponseModelNewFromJson(String str) =>
    GetMyPlantResponseModelNew.fromJson(json.decode(str));

String getMyPlantResponseModelNewToJson(GetMyPlantResponseModelNew data) =>
    json.encode(data.toJson());

class GetMyPlantResponseModelNew {
  final String? message;
  final int? code;
  final String? status;
  final Data? data;

  GetMyPlantResponseModelNew({
    this.message,
    this.code,
    this.status,
    this.data,
  });

  factory GetMyPlantResponseModelNew.fromJson(Map<String, dynamic> json) =>
      GetMyPlantResponseModelNew(
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
  final List<Plant>? plants;
  final int? limit;
  final int? page;
  final int? totalCount;
  final int? totalPages;

  Data({
    this.plants,
    this.limit,
    this.page,
    this.totalCount,
    this.totalPages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        plants: json["plants"] == null
            ? []
            : List<Plant>.from(json["plants"]!.map((x) => Plant.fromJson(x))),
        limit: json["limit"],
        page: json["page"],
        totalCount: json["total_count"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "plants": plants == null
            ? []
            : List<dynamic>.from(plants!.map((x) => x.toJson())),
        "limit": limit,
        "page": page,
        "total_count": totalCount,
        "total_pages": totalPages,
      };
}

class Plant {
  final int? id;
  final String? name;
  final String? description;
  final bool? isToxic;
  final int? harvestDuration;
  final Category? plantCategory;
  final String? climateCondition;
  final String? plantingTime;
  final String? sunlight;
  final PlantCharacteristic? plantCharacteristic;
  final WateringSchedule? wateringSchedule;
  final List<PlantInstruction>? plantInstructions;
  final String? additionalTips;
  final List<PlantFaq>? plantFaqs;
  final List<PlantImage>? plantImages;
  final DateTime? createdAt;

  Plant({
    this.id,
    this.name,
    this.description,
    this.isToxic,
    this.harvestDuration,
    this.plantCategory,
    this.climateCondition,
    this.plantingTime,
    this.sunlight,
    this.plantCharacteristic,
    this.wateringSchedule,
    this.plantInstructions,
    this.additionalTips,
    this.plantFaqs,
    this.plantImages,
    this.createdAt,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        isToxic: json["is_toxic"],
        harvestDuration: json["harvest_duration"],
        plantCategory: json["plant_category"] == null
            ? null
            : Category.fromJson(json["plant_category"]),
        climateCondition: json["climate_condition"],
        plantingTime: json["planting_time"],
        sunlight: json["sunlight"],
        plantCharacteristic: json["plant_characteristic"] == null
            ? null
            : PlantCharacteristic.fromJson(json["plant_characteristic"]),
        wateringSchedule: json["watering_schedule"] == null
            ? null
            : WateringSchedule.fromJson(json["watering_schedule"]),
        plantInstructions: json["plant_instructions"] == null
            ? []
            : List<PlantInstruction>.from(json["plant_instructions"]!
                .map((x) => PlantInstruction.fromJson(x))),
        additionalTips: json["additional_tips"],
        plantFaqs: json["plant_faqs"] == null
            ? []
            : List<PlantFaq>.from(
                json["plant_faqs"]!.map((x) => PlantFaq.fromJson(x))),
        plantImages: json["plant_images"] == null
            ? []
            : List<PlantImage>.from(
                json["plant_images"]!.map((x) => PlantImage.fromJson(x))),
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
        "plant_category": plantCategory?.toJson(),
        "climate_condition": climateCondition,
        "planting_time": plantingTime,
        "sunlight": sunlight,
        "plant_characteristic": plantCharacteristic?.toJson(),
        "watering_schedule": wateringSchedule?.toJson(),
        "plant_instructions": plantInstructions == null
            ? []
            : List<dynamic>.from(plantInstructions!.map((x) => x.toJson())),
        "additional_tips": additionalTips,
        "plant_faqs": plantFaqs == null
            ? []
            : List<dynamic>.from(plantFaqs!.map((x) => x.toJson())),
        "plant_images": plantImages == null
            ? []
            : List<dynamic>.from(plantImages!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
      };
}

class Category {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? description;

  Category({
    this.id,
    this.name,
    this.imageUrl,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "description": description,
      };
}

class PlantCharacteristic {
  final int? id;
  final int? height;
  final String? heightUnit;
  final int? wide;
  final String? wideUnit;
  final String? leafColor;

  PlantCharacteristic({
    this.id,
    this.height,
    this.heightUnit,
    this.wide,
    this.wideUnit,
    this.leafColor,
  });

  factory PlantCharacteristic.fromJson(Map<String, dynamic> json) =>
      PlantCharacteristic(
        id: json["id"],
        height: json["height"],
        heightUnit: json["height_unit"],
        wide: json["wide"],
        wideUnit: json["wide_unit"],
        leafColor: json["leaf_color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "height": height,
        "height_unit": heightUnit,
        "wide": wide,
        "wide_unit": wideUnit,
        "leaf_color": leafColor,
      };
}

class PlantFaq {
  final int? id;
  final int? plantId;
  final String? question;
  final String? answer;
  final DateTime? createdAt;

  PlantFaq({
    this.id,
    this.plantId,
    this.question,
    this.answer,
    this.createdAt,
  });

  factory PlantFaq.fromJson(Map<String, dynamic> json) => PlantFaq(
        id: json["id"],
        plantId: json["plant_id"],
        question: json["question"],
        answer: json["answer"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "question": question,
        "answer": answer,
        "created_at": createdAt?.toIso8601String(),
      };
}

class PlantImage {
  final int? id;
  final int? plantId;
  final String? fileName;
  final int? isPrimary;

  PlantImage({
    this.id,
    this.plantId,
    this.fileName,
    this.isPrimary,
  });

  factory PlantImage.fromJson(Map<String, dynamic> json) => PlantImage(
        id: json["id"],
        plantId: json["plant_id"],
        fileName: json["file_name"],
        isPrimary: json["is_primary"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "file_name": fileName,
        "is_primary": isPrimary,
      };
}

class PlantInstruction {
  final int? id;
  final int? plantId;
  final Category? instructionCategory;
  final int? stepNumber;
  final String? stepTitle;
  final String? stepDescription;
  final String? stepImageUrl;

  PlantInstruction({
    this.id,
    this.plantId,
    this.instructionCategory,
    this.stepNumber,
    this.stepTitle,
    this.stepDescription,
    this.stepImageUrl,
  });

  factory PlantInstruction.fromJson(Map<String, dynamic> json) =>
      PlantInstruction(
        id: json["id"],
        plantId: json["plant_id"],
        instructionCategory: json["instruction_category"] == null
            ? null
            : Category.fromJson(json["instruction_category"]),
        stepNumber: json["step_number"],
        stepTitle: json["step_title"],
        stepDescription: json["step_description"],
        stepImageUrl: json["step_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "instruction_category": instructionCategory?.toJson(),
        "step_number": stepNumber,
        "step_title": stepTitle,
        "step_description": stepDescription,
        "step_image_url": stepImageUrl,
      };
}

class WateringSchedule {
  final int? id;
  final int? plantId;
  final int? wateringFrequency;
  final String? each;
  final int? wateringAmount;
  final String? unit;
  final String? wateringTime;
  final String? weatherCondition;
  final String? conditionDescription;

  WateringSchedule({
    this.id,
    this.plantId,
    this.wateringFrequency,
    this.each,
    this.wateringAmount,
    this.unit,
    this.wateringTime,
    this.weatherCondition,
    this.conditionDescription,
  });

  factory WateringSchedule.fromJson(Map<String, dynamic> json) =>
      WateringSchedule(
        id: json["id"],
        plantId: json["plant_id"],
        wateringFrequency: json["watering_frequency"],
        each: json["each"],
        wateringAmount: json["watering_amount"],
        unit: json["unit"],
        wateringTime: json["watering_time"],
        weatherCondition: json["weather_condition"],
        conditionDescription: json["condition_description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plant_id": plantId,
        "watering_frequency": wateringFrequency,
        "each": each,
        "watering_amount": wateringAmount,
        "unit": unit,
        "watering_time": wateringTime,
        "weather_condition": weatherCondition,
        "condition_description": conditionDescription,
      };
}
