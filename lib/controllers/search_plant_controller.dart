import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';
import 'package:plantopia/models/get_search_plant_response.dart';
import 'package:plantopia/service/search_plant_service.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPlantController extends GetxController {
  SearchPlantService searchPlantService = SearchPlantService();
  SearchedPlantResponse? searchedPlantResponse;
  PlantByIdResponse? plantByIdResponse;
  TextEditingController searchPlantText = TextEditingController();
  final addPlantController = Get.put(AddPlantController());
  RxBool isFirstTimeOpen = true.obs;
  RxBool isHaveResult = false.obs;
  RxBool isPageLoading = false.obs;
  RxList<String> searchHistory = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSearchHistory();
  }

  @override
  void onClose() {
    addPlantController.isFilterSearchResulted(false);
    super.onClose();
  }

  Future<void> searchPlant(String plantName) async {
    try {
      isPageLoading(true);
      searchedPlantResponse =
          await searchPlantService.searchPlantByName(plantName);
      isFirstTimeOpen(false);
      isHaveResult(true);
      isPageLoading(false);

      _addSearchHistory(plantName);
    } on DioException {
      isHaveResult(false);
      isPageLoading(false);
      isFirstTimeOpen(false);
    }
  }

  Future<void> _loadSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchHistory.value = prefs.getStringList('searchHistory') ?? [];
  }

  Future<void> _addSearchHistory(String plantName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchHistory.remove(plantName);
    searchHistory.insert(0, plantName);
    if (searchHistory.length > 2) {
      searchHistory.removeLast();
    }
    await prefs.setStringList('searchHistory', searchHistory);
  }
}
