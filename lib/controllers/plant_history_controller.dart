import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/models/get_panting_history_response.dart';
import 'package:plantopia/service/planting_history_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class PlantHistoryController extends GetxController {
  RxList<PlantHistory> todayHistory = <PlantHistory>[].obs;
  RxList<PlantHistory> yesterdayHistory = <PlantHistory>[].obs;
  RxList<PlantHistory> thisWeekHistory = <PlantHistory>[].obs;
  RxList<PlantHistory> thisMonthHistory = <PlantHistory>[].obs;
  RxList<PlantHistory> thisYearHistory = <PlantHistory>[].obs;
  RxList<PlantHistory> lastYearHistory = <PlantHistory>[].obs;
  RxList<PlantHistory> listPlantingHistory = <PlantHistory>[].obs;
  Rx<Status> plantingHistoryData = Status.loading.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getPlantingHistory();
    await plantingHistorySplit();
    reverseAllLists();
  }

  void reverseList(RxList<PlantHistory> list) {
    int length = list.length;
    for (int i = 0; i < length ~/ 2; i++) {
      PlantHistory temp = list[i];
      list[i] = list[length - 1 - i];
      list[length - 1 - i] = temp;
    }
  }

  // Fungsi untuk membalik urutan indeks dalam semua RxList yang Anda miliki
  void reverseAllLists() {
    reverseList(todayHistory);
    reverseList(yesterdayHistory);
    reverseList(thisWeekHistory);
    reverseList(thisMonthHistory);
    reverseList(thisYearHistory);
    reverseList(lastYearHistory);
  }

  String parseDate(DateTime dateTime) {
    String plantingDate = DateFormat('dd MMMM yyyy').format(dateTime);
    return plantingDate;
  }

  Future<void> getPlantingHistory() async {
    try {
      plantingHistoryData.value = Status.loading;
      final response = await PlantingHistoryService.getPlantingHistory();
      listPlantingHistory.value = response.data ?? [];
      plantingHistoryData.value = Status.loaded;
    } catch (e) {
      plantingHistoryData.value = Status.error;
    }
  }

  Future<void> addPlantingHistory(int plantId) async {
    try {
      await PlantingHistoryService.addPlantingHistory(plantId);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> plantingHistorySplit() async {
    try {
      plantingHistoryData.value = Status.loading;
      DateTime now = DateTime.now();
      final response = await PlantingHistoryService.getPlantingHistory();
      for (PlantHistory plant in response.data ?? []) {
        final plantHistoryTime = plant.createdAt ?? DateTime(-1);
        Duration difference = now.difference(plantHistoryTime);
        int years = difference.inDays ~/ 365;
        int months = (difference.inDays % 365) ~/ 30;
        int weeks = ((difference.inDays % 365) % 30) ~/ 7;
        int days = ((difference.inDays % 365) % 30) % 7;
        if (years > 1) {
          lastYearHistory.add(plant);
        } else if (years > 0 && years <= 1) {
          thisYearHistory.add(plant);
        } else if (months > 0) {
          thisMonthHistory.add(plant);
        } else if (weeks > 0) {
          thisWeekHistory.add(plant);
        } else if (days == 1) {
          yesterdayHistory.add(plant);
        } else {
          todayHistory.add(plant);
        }
      }
      plantingHistoryData.value = Status.loaded;
    } catch (e) {
      plantingHistoryData.value = Status.error;
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
