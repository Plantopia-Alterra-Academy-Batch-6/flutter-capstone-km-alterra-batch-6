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
  RxBool isFiltering = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await splitWateringHistory();
  }

  String extractPlantName(String input) {
    int index = input.indexOf('-');
    if (index != -1) {
      return input.substring(0, index).trim();
    } else {
      return input.trim();
    }
  }

  String extractFamilyName(String input) {
    int index = input.indexOf('-');
    if (index != -1) {
      return input.substring(index + 1).trim();
    } else {
      return '';
    }
  }

  Future<void> sortAtoZ() async {
    listWateringHistory.sort(
      (a, b) => a.plant!.name!
          .toLowerCase()
          .compareTo(b.plant!.name?.toLowerCase() ?? "-"),
    );
    isFiltering.value = true;
  }

  Future<void> sortZtoA() async {
    listWateringHistory.sort(
      (a, b) => b.plant!.name!
          .toLowerCase()
          .compareTo(a.plant!.name?.toLowerCase() ?? "-"),
    );
    isFiltering.value = true;
  }

  String parseDate(DateTime dateTime) {
    String plantingDate = DateFormat('EEEE, dd MMMM yyyy').format(dateTime);
    return plantingDate;
  }

  String parseHour(DateTime wateringTime) {
    DateTime newTime = wateringTime.add(const Duration(hours: 7));
    DateFormat formatter = DateFormat('h:mm a');
    String formattedTime = formatter.format(newTime);
    return formattedTime;
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
      listWateringHistory.value = response.data ?? [];
      for (WateringHistory wateringHistory in response.data ?? []) {
        final wateringHistoryTime = wateringHistory.createdAt ?? DateTime(-1);
        Duration difference = now.difference(wateringHistoryTime);
        int years = difference.inDays ~/ 365;
        int days = ((difference.inDays % 365) % 30) % 7;
        if (years > 1) {
          lastYearHistory.add(wateringHistory);
        } else if (days > 30 && days <= 365) {
          thisYearHistory.add(wateringHistory);
        } else if (days > 7 && days <= 30) {
          thisMonthHistory.add(wateringHistory);
        } else if (days > 1 && days <= 7) {
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
}
