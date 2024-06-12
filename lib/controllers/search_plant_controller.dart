
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/helpers/shared_pref_helper.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';
import 'package:plantopia/models/get_search_plant_response.dart';
import 'package:plantopia/service/search_plant_service.dart';
import 'package:dio/dio.dart';

class SearchPlantController extends GetxController {
  SearchPlantService searchPlantService = SearchPlantService();
  SearchedPlantResponse? searchedPlantResponse;
  PlantByIdResponse? plantByIdResponse;
  TextEditingController searchPlantText = TextEditingController();
  RxBool isFirstTimeOpen = true.obs;
  RxBool isHaveResult = false.obs; 
  RxBool isPageLoading = false.obs;

  Future<void> searchPlant(String plantName) async {
    try {
      isPageLoading(true);
      searchedPlantResponse = await searchPlantService.searchPlantByName(plantName);
      isFirstTimeOpen(false);
      isHaveResult(true);
      isPageLoading(false);

      SharedPrefHelper.storeUserSearchHistory(plantName);

    } on DioException {
      isHaveResult(false);
      isPageLoading(false);
      isFirstTimeOpen(false);
    }
  }
}