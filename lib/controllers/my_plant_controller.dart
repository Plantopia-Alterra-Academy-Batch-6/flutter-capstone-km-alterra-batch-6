import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import 'package:plantopia/models/get_plant_category_response.dart';
import 'package:plantopia/models/get_plant_recommendations_response.dart';
import 'package:plantopia/service/add_plant_service.dart';
import 'package:plantopia/service/my_plant_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class MyPlantController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<Status> myPlantData = Status.loading.obs;
  Rx<Status> recommendationData = Status.loading.obs;
  Rx<Status> categoryData = Status.loading.obs;

  RxList<PlantElement> listMyPlant = <PlantElement>[].obs;
  RxList<Plant> recommendationPlant = <Plant>[].obs;

  AddPlantService addPlantService = AddPlantService();
  PlantCategoriesResponse? plantCategoriesResponse;
  PlantRecommendationsResponse? plantRecommendationsResponse;
  RxBool isPageLoading = false.obs;
  var activeIndex = (-1).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    getMyPlant();
    getAllCategories();
    getRecommendationPlant();
  }

  Future<void> init() async {
    super.onInit();
    getMyPlant();
    getAllCategories();
    getRecommendationPlant();
  }

  Future<void> getMyPlant() async {
    try {
      myPlantData.value = Status.loading;
      final response = await MyPlantService.getMyPlant();
      listMyPlant.value = response.data?.plants ?? [];
      myPlantData.value = Status.loaded;
    } catch (e) {
      myPlantData.value = Status.error;
    }
  }

  Future<void> getRecommendationPlant() async {
    try {
      recommendationData.value = Status.loading;
      final response = await MyPlantService.getRecommendationPlant();
      recommendationPlant.value = response.data ?? [];
      recommendationData.value = Status.loaded;
    } catch (e) {
      recommendationData.value = Status.error;
    }
  }

  Future<void> getPlantByCatergories(int id) async {
    try {
      recommendationData.value = Status.loading;
      final response = await MyPlantService.getPlantByCategories(id);
      recommendationPlant.value = response.data ?? [];
      recommendationData.value = Status.loaded;
    } catch (e) {
      recommendationData.value = Status.error;
    }
  }

  void currentIndex(int index) async {
    activeIndex.value = index;
  }

  void getAllCategories() async {
    try {
      categoryData.value = Status.loading;
      plantCategoriesResponse = await addPlantService.getAllPlantCategory();
      categoryData.value = Status.loaded;
    } catch (e) {
      categoryData.value = Status.error;
    }
  }

 
}
