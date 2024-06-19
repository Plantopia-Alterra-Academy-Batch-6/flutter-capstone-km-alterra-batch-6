import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:plantopia/models/get_plant_progress_response_model.dart';
import 'package:plantopia/service/my_plant_details_service.dart';
import 'package:plantopia/service/upload_progress_service.dart';

class MyPlantDetailsController extends GetxController {
  RxInt activeIndex = 0.obs;
  RxBool customIcon = false.obs;
  RxBool isSuccess = false.obs;
  RxList<PlantProgress> progressPlant = <PlantProgress>[].obs;
  TextEditingController changeNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    changeNameController.dispose();
  }

  Future<void> getPlantProgress(int plantId) async {
    try {
      final GetPlantProgressResponseModel? result =
          await UploadProgressService.getPlantProgress(plantId);
      List<PlantProgress>? progressPlantResult = result?.data?.plantProgress;
      progressPlant.value = progressPlantResult ?? [];
    } catch (e) {
      throw Exception(e);
    }
  }

  String filterHtmlTag(String htmlString) {
    dom.Document document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }

  String parseHour(String wateringSchedule) {
    DateTime time = DateFormat.Hm().parse(wateringSchedule);

    DateFormat formatter = DateFormat('hh:mm a');

    String formattedTime = formatter.format(time);

    return formattedTime;
  }

  String parseDate(DateTime dateTime) {
    String plantingDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return plantingDate;
  }

  String plantAge(DateTime plantingDate) {
    String plantAge = "";
    DateTime now = DateTime.now();
    Duration difference = now.difference(plantingDate);

    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30;
    int weeks = ((difference.inDays % 365) % 30) ~/ 7;
    int days = ((difference.inDays % 365) % 30) % 7;
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);

    if (years > 0) {
      plantAge = '$years years ';
    } else if (months > 0) {
      plantAge = '$months months ';
    } else if (weeks > 0) {
      plantAge = '$weeks weeks ';
    } else if (days > 0) {
      plantAge = '$days days ';
    } else if (hours > 0) {
      plantAge = '$hours hours ';
    } else if (minutes > 0) {
      plantAge = '$minutes minutes ';
    } else if (seconds > 0) {
      plantAge = '$seconds seconds ';
    }
    return plantAge;
  }

  Future<void> deleteMyplant(int plantId) async {
    try {
      await MyPlantDetailsService.deleteMyPlant(plantId);
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to delete my plant, please try again!",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  Future<void> createCustomizeName(int plantId, String newName) async {
    try {
      await MyPlantDetailsService.createCustomName(plantId, newName);
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to customize plant name, please try again!",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
