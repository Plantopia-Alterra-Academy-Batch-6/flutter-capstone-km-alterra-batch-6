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
  RxInt selectedFilter = 1.obs;
  RxBool isFiltering = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await plantingHistorySplit();
    reverseAllLists();
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
    listPlantingHistory.sort(
      (a, b) => a.plantName!
          .toLowerCase()
          .compareTo(b.plantName?.toLowerCase() ?? "-"),
    );
    isFiltering.value = true;
  }

  Future<void> sortZtoA() async {
    listPlantingHistory.sort(
      (a, b) => b.plantName!
          .toLowerCase()
          .compareTo(a.plantName?.toLowerCase() ?? "-"),
    );
    isFiltering.value = true;
  }

  Future<void> reverseList(RxList<PlantHistory> list) async {
    int length = list.length;
    for (int i = 0; i < length ~/ 2; i++) {
      PlantHistory temp = list[i];
      list[i] = list[length - 1 - i];
      list[length - 1 - i] = temp;
    }
  }

  void reverseAllLists() async {
    reverseList(todayHistory);
    reverseList(yesterdayHistory);
    reverseList(thisWeekHistory);
    reverseList(thisMonthHistory);
    reverseList(thisYearHistory);
    reverseList(lastYearHistory);
  }

  String parseDate(DateTime dateTime) {
    DateTime newTime = dateTime.add(const Duration(hours: 7));
    String plantingDate = DateFormat('dd MMMM yyyy').format(newTime);
    return plantingDate;
  }

  Future<void> getPlantingHistory() async {
    try {
      final response = await PlantingHistoryService.getPlantingHistory();
      listPlantingHistory.value = response.data ?? [];
      isFiltering.value = true;
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
      listPlantingHistory.value = response.data ?? [];
      for (PlantHistory plant in response.data ?? []) {
        final plantHistoryTime = plant.createdAt ?? DateTime(-1);
        Duration difference = now.difference(plantHistoryTime);
        int years = difference.inDays ~/ 365;
        int days = difference.inDays;
        if (years >= 1) {
          lastYearHistory.add(plant);
        } else if (days > 31) {
          thisYearHistory.add(plant);
        } else if (days > 7) {
          thisMonthHistory.add(plant);
        } else if (days > 1) {
          thisWeekHistory.add(plant);
        } else if (days == 1) {
          yesterdayHistory.add(plant);
        } else {
          todayHistory.add(plant);
        }
      }
      plantingHistoryData.value = Status.loaded;
      isFiltering.value = false;
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
