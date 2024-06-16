import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/models/get_watering_history_response.dart';
import 'package:plantopia/service/watering_history_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class WateringHistoryController extends GetxController {
  RxList<WateringHistory> todayHistory = <WateringHistory>[].obs;
  RxList<WateringHistory> yesterdayHistory = <WateringHistory>[].obs;
  RxList<WateringHistory> thisWeekHistory = <WateringHistory>[].obs;
  RxList<WateringHistory> thisMonthHistory = <WateringHistory>[].obs;
  RxList<WateringHistory> thisYearHistory = <WateringHistory>[].obs;
  RxList<WateringHistory> lastYearHistory = <WateringHistory>[].obs;
  RxList<WateringHistory> listWateringHistory = <WateringHistory>[].obs;
  Rx<Status> wateringDataStatus = Status.loading.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAllWateringHistory();
    await splitWateringHistory();
  }

  String parseDate(DateTime dateTime) {
    String plantingDate = DateFormat('EEEE, dd MMMM yyyy').format(dateTime);
    return plantingDate;
  }

  String parseHour(DateTime wateringTime) {
    DateFormat formatter = DateFormat('h:mm a');
    String formattedTime = formatter.format(wateringTime);
    return formattedTime;
  }

  Future<void> getAllWateringHistory() async {
    try {
      wateringDataStatus.value = Status.loading;
      final response = await WateringHistoryService.getWateringHistory();
      listWateringHistory.value = response.data ?? [];
      wateringDataStatus.value = Status.loaded;
    } catch (e) {
      wateringDataStatus.value = Status.error;
    }
  }

  static Future<void> postWatering(int plantId) async {
    try {
      await WateringHistoryService.postWatering(plantId);
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to watering plant, please try again!",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  Future<void> splitWateringHistory() async {
    try {
      wateringDataStatus.value = Status.loading;
      DateTime now = DateTime.now();
      final response = await WateringHistoryService.getWateringHistory();
      for (WateringHistory wateringHistory in response.data ?? []) {
        final wateringHistoryTime = wateringHistory.createdAt ?? DateTime(-1);
        Duration difference = now.difference(wateringHistoryTime);
        int years = difference.inDays ~/ 365;
        int months = (difference.inDays % 365) ~/ 30;
        int weeks = ((difference.inDays % 365) % 30) ~/ 7;
        int days = ((difference.inDays % 365) % 30) % 7;
        if (years > 1) {
          lastYearHistory.add(wateringHistory);
        } else if (years > 0 && years <= 1) {
          thisYearHistory.add(wateringHistory);
        } else if (months > 0) {
          thisMonthHistory.add(wateringHistory);
        } else if (weeks > 0) {
          thisWeekHistory.add(wateringHistory);
        } else if (days == 1) {
          yesterdayHistory.add(wateringHistory);
        } else {
          todayHistory.add(wateringHistory);
        }
      }
      wateringDataStatus.value = Status.loaded;
    } catch (e) {
      wateringDataStatus.value = Status.error;
    }
  }

  Future<void> refreshPlantingHistory() async {
    todayHistory.value = [];
    yesterdayHistory.value = [];
    thisWeekHistory.value = [];
    thisMonthHistory.value = [];
    thisYearHistory.value = [];
  }
}
