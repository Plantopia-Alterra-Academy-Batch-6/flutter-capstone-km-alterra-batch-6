class PlantFilterSearchResultResponse {
  String? status;
  String? message;
  List<PlantData>? data;

  PlantFilterSearchResultResponse({this.status, this.message, this.data});

  PlantFilterSearchResultResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlantData>[];
      json['data'].forEach((v) {
        data?.add(PlantData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlantData {
  int? id;
  String? name;
  String? description;
  bool? isToxic;
  int? harvestDuration;
  String? sunlight;
  String? plantingTime;
  int? plantCategoryId;
  PlantCategory? plantCategory;
  String? climateCondition;
  int? plantCharacteristicId;
  PlantCharacteristic? plantCharacteristic;
  WateringSchedule? wateringSchedule;
  List<PlantInstruction>? plantInstructions;
  String? additionalTips;
  List<PlantFAQ>? plantFaqs;
  List<PlantImage>? plantImages;
  String? createdAt;
  String? updatedAt;

  PlantData({
    this.id,
    this.name,
    this.description,
    this.isToxic,
    this.harvestDuration,
    this.sunlight,
    this.plantingTime,
    this.plantCategoryId,
    this.plantCategory,
    this.climateCondition,
    this.plantCharacteristicId,
    this.plantCharacteristic,
    this.wateringSchedule,
    this.plantInstructions,
    this.additionalTips,
    this.plantFaqs,
    this.plantImages,
    this.createdAt,
    this.updatedAt,
  });

  PlantData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isToxic = json['is_toxic'];
    harvestDuration = json['harvest_duration'];
    sunlight = json['sunlight'];
    plantingTime = json['planting_time'];
    plantCategoryId = json['plant_category_id'];
    plantCategory = json['plant_category'] != null
        ? PlantCategory.fromJson(json['plant_category'])
        : null;
    climateCondition = json['climate_condition'];
    plantCharacteristicId = json['plant_characteristic_id'];
    plantCharacteristic = json['plant_characteristic'] != null
        ? PlantCharacteristic.fromJson(json['plant_characteristic'])
        : null;
    wateringSchedule = json['watering_schedule'] != null
        ? WateringSchedule.fromJson(json['watering_schedule'])
        : null;
    if (json['plant_instructions'] != null) {
      plantInstructions = <PlantInstruction>[];
      json['plant_instructions'].forEach((v) {
        plantInstructions?.add(PlantInstruction.fromJson(v));
      });
    }
    additionalTips = json['additional_tips'];
    if (json['plant_faqs'] != null) {
      plantFaqs = <PlantFAQ>[];
      json['plant_faqs'].forEach((v) {
        plantFaqs?.add(PlantFAQ.fromJson(v));
      });
    }
    if (json['plant_images'] != null) {
      plantImages = <PlantImage>[];
      json['plant_images'].forEach((v) {
        plantImages?.add(PlantImage.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['is_toxic'] = isToxic;
    data['harvest_duration'] = harvestDuration;
    data['sunlight'] = sunlight;
    data['planting_time'] = plantingTime;
    data['plant_category_id'] = plantCategoryId;
    data['plant_category'] = plantCategory?.toJson();
    data['climate_condition'] = climateCondition;
    data['plant_characteristic_id'] = plantCharacteristicId;
    data['plant_characteristic'] = plantCharacteristic?.toJson();
    data['watering_schedule'] = wateringSchedule?.toJson();
    if (plantInstructions != null) {
      data['plant_instructions'] =
          plantInstructions?.map((v) => v.toJson()).toList();
    }
    data['additional_tips'] = additionalTips;
    if (plantFaqs != null) {
      data['plant_faqs'] = plantFaqs?.map((v) => v.toJson()).toList();
    }
    if (plantImages != null) {
      data['plant_images'] = plantImages?.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PlantCategory {
  int? id;
  String? name;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  PlantCategory(
      {this.id, this.name, this.imageUrl, this.createdAt, this.updatedAt});

  PlantCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PlantCharacteristic {
  int? id;
  int? plantId;
  int? height;
  String? heightUnit;
  int? wide;
  String? wideUnit;
  String? leafColor;

  PlantCharacteristic(
      {this.id,
      this.plantId,
      this.height,
      this.heightUnit,
      this.wide,
      this.wideUnit,
      this.leafColor});

  PlantCharacteristic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantId = json['plant_id'];
    height = json['height'];
    heightUnit = json['height_unit'];
    wide = json['wide'];
    wideUnit = json['wide_unit'];
    leafColor = json['leaf_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plant_id'] = plantId;
    data['height'] = height;
    data['height_unit'] = heightUnit;
    data['wide'] = wide;
    data['wide_unit'] = wideUnit;
    data['leaf_color'] = leafColor;
    return data;
  }
}

class WateringSchedule {
  int? id;
  int? plantId;
  int? wateringFrequency;
  String? each;
  int? wateringAmount;
  String? unit;
  String? wateringTime;
  String? weatherCondition;
  String? conditionDescription;
  String? createdAt;
  String? updatedAt;

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
    this.createdAt,
    this.updatedAt,
  });

  WateringSchedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantId = json['plant_id'];
    wateringFrequency = json['watering_frequency'];
    each = json['each'];
    wateringAmount = json['watering_amount'];
    unit = json['unit'];
    wateringTime = json['watering_time'];
    weatherCondition = json['weather_condition'];
    conditionDescription = json['condition_description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plant_id'] = plantId;
    data['watering_frequency'] = wateringFrequency;
    data['each'] = each;
    data['watering_amount'] = wateringAmount;
    data['unit'] = unit;
    data['watering_time'] = wateringTime;
    data['weather_condition'] = weatherCondition;
    data['condition_description'] = conditionDescription;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PlantInstruction {
  int? id;
  int? plantId;
  int? instructionCategoryId;
  InstructionCategory? instructionCategory;
  int? stepNumber;
  String? stepTitle;
  String? stepDescription;
  String? stepImageUrl;
  String? createdAt;
  String? updatedAt;

  PlantInstruction({
    this.id,
    this.plantId,
    this.instructionCategoryId,
    this.instructionCategory,
    this.stepNumber,
    this.stepTitle,
    this.stepDescription,
    this.stepImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  PlantInstruction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantId = json['plant_id'];
    instructionCategoryId = json['instruction_category_id'];
    instructionCategory = json['instruction_category'] != null
        ? InstructionCategory.fromJson(json['instruction_category'])
        : null;
    stepNumber = json['step_number'];
    stepTitle = json['step_title'];
    stepDescription = json['step_description'];
    stepImageUrl = json['step_image_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plant_id'] = plantId;
    data['instruction_category_id'] = instructionCategoryId;
    data['instruction_category'] = instructionCategory?.toJson();
    data['step_number'] = stepNumber;
    data['step_title'] = stepTitle;
    data['step_description'] = stepDescription;
    data['step_image_url'] = stepImageUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class InstructionCategory {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;

  InstructionCategory(
      {this.id, this.name, this.description, this.createdAt, this.updatedAt});

  InstructionCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PlantFAQ {
  int? id;
  int? plantId;
  String? question;
  String? answer;
  String? createdAt;
  String? updatedAt;

  PlantFAQ(
      {this.id,
      this.plantId,
      this.question,
      this.answer,
      this.createdAt,
      this.updatedAt});

  PlantFAQ.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantId = json['plant_id'];
    question = json['question'];
    answer = json['answer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plant_id'] = plantId;
    data['question'] = question;
    data['answer'] = answer;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PlantImage {
  int? id;
  int? plantId;
  String? fileName;
  String? createdAt;
  String? updatedAt;

  PlantImage(
      {this.id, this.plantId, this.fileName, this.createdAt, this.updatedAt});

  PlantImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plantId = json['plant_id'];
    fileName = json['file_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plant_id'] = plantId;
    data['file_name'] = fileName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
