import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import 'package:plantopia/models/get_plant_category_response.dart';
import 'package:plantopia/models/get_plant_recommendations_response.dart';
import 'package:plantopia/service/add_plant_service.dart';
import 'package:plantopia/service/auth_service.dart';
import 'package:plantopia/service/my_plant_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class MyPlantController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<Status> myPlantData = Status.loading.obs;
  Rx<Status> recommendationData = Status.loading.obs;
  Rx<Status> categoryData = Status.loading.obs;
  RxBool isActive = false.obs;

  ScrollController scrollController = ScrollController();

  RxBool showFloatingButton =
      true.obs; // State untuk mengontrol tampilan Floating Action Button

  RxList<PlantElement> listMyPlant = <PlantElement>[].obs;
  RxList<PlantElement> searchMyPlant = <PlantElement>[].obs;
  RxList<Plant> recommendationPlant = <Plant>[].obs;

  AddPlantService addPlantService = AddPlantService();
  PlantCategoriesResponse? plantCategoriesResponse;
  PlantRecommendationsResponse? plantRecommendationsResponse;
  RxBool isPageLoading = false.obs;
  var activeIndex = (-1).obs;
  RxBool isSearchFound = false.obs;

  final AuthController authController = Get.put(AuthController());

  @override
  Future<void> onInit() async {
    super.onInit();
    await authController.getUser();
    getMyPlant();
    getAllCategories();
    getRecommendationPlant();

    scrollController.addListener(() {
      // Jika posisi scroll berubah, periksa apakah harus menampilkan Floating Action Button
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showFloatingButton.value =
            false; // Sembunyikan Floating Action Button saat menggulir ke bawah
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloatingButton.value = true; //
      }
    });
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

  Future<void> searchPlant(String value) async {
    var totalData = listMyPlant.length;
    List<PlantElement> listsearchPlantTemp = [];

    for (int i = 0; i < totalData; i++) {
      if (listMyPlant[i].plant!.name!.toLowerCase() == value.toLowerCase() ||
          listMyPlant[i]
                  .plant!
                  .name!
                  .toLowerCase()
                  .contains(value.toLowerCase()) &&
              listMyPlant[i]
                  .plant!
                  .name!
                  .toLowerCase()
                  .startsWith(value.toLowerCase()) ||
          listMyPlant[i].customizeName?.toLowerCase() == value.toLowerCase() ||
          listMyPlant[i]
                  .customizeName!
                  .toLowerCase()
                  .contains(value.toLowerCase()) &&
              listMyPlant[i]
                  .customizeName!
                  .toLowerCase()
                  .startsWith(value.toLowerCase())) {
        listsearchPlantTemp.add(listMyPlant[i]);
        isSearchFound(true);
      }
    }
    searchMyPlant.value = listsearchPlantTemp;
  }
}
