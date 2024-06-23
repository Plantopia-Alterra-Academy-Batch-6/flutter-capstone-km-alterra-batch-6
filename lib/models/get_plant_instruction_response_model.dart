import 'dart:convert';

GetPlantInstructionResponseModel getPlantInstructionResponseModelFromJson(
        String str) =>
    GetPlantInstructionResponseModel.fromJson(json.decode(str));

String getPlantInstructionResponseModelToJson(
        GetPlantInstructionResponseModel data) =>
    json.encode(data.toJson());

class GetPlantInstructionResponseModel {
  final String? message;
  final int? code;
  final String? status;
  final Data? data;

  GetPlantInstructionResponseModel({
    this.message,
    this.code,
    this.status,
    this.data,
  });

  factory GetPlantInstructionResponseModel.fromJson(
          Map<String, dynamic> json) =>
      GetPlantInstructionResponseModel(
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
  final int? plantId;
  final InstructionCategory? instructionCategory;
  final List<Step>? steps;

  Data({
    this.plantId,
    this.instructionCategory,
    this.steps,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        plantId: json["plant_id"],
        instructionCategory: json["instruction_category"] == null
            ? null
            : InstructionCategory.fromJson(json["instruction_category"]),
        steps: json["steps"] == null
            ? []
            : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "plant_id": plantId,
        "instruction_category": instructionCategory?.toJson(),
        "steps": steps == null
            ? []
            : List<dynamic>.from(steps!.map((x) => x.toJson())),
      };
}

class InstructionCategory {
  final int? id;
  final String? name;
  final String? description;
  final String? imageUrl;

  InstructionCategory({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
  });

  factory InstructionCategory.fromJson(Map<String, dynamic> json) =>
      InstructionCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image_url": imageUrl,
      };
}

class Step {
  final int? id;
  final int? stepNumber;
  final String? stepTitle;
  final String? stepDescription;
  final String? stepImageUrl;

  Step({
    this.id,
    this.stepNumber,
    this.stepTitle,
    this.stepDescription,
    this.stepImageUrl,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        id: json["id"],
        stepNumber: json["step_number"],
        stepTitle: json["step_title"],
        stepDescription: json["step_description"],
        stepImageUrl: json["step_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "step_number": stepNumber,
        "step_title": stepTitle,
        "step_description": stepDescription,
        "step_image_url": stepImageUrl,
      };
}
