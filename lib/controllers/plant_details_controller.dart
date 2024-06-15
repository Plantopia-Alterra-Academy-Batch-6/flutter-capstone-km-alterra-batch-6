import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/controllers/search_plant_controller.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';
import 'package:plantopia/service/plant_details_service.dart';
import 'package:plantopia/utils/app_routes.dart';

class PlantDetailsController extends GetxController {
  final addPlantController = Get.put(AddPlantController());
  final myPlantController = Get.put(MyPlantController());
  PlantDetailsService plantDetailsService = PlantDetailsService();
  PlantByIdResponse? plantByIdResponse;
  RxBool isPageLoading = false.obs;
  RxInt activeIndex = 0.obs;
  RxBool customIcon = false.obs;

  @override
  void onInit() {
    getPlantDetails();
    super.onInit();
  }

  void getPlantDetails() async {
    isPageLoading(true);
    plantByIdResponse = await plantDetailsService
        .getPlantById(addPlantController.selectedPlant.value);
    isPageLoading(false);
  }

  Future<void> addPlant(int id) async {
    try {
      await plantDetailsService.addPlant(id);
      await myPlantController.getMyPlant();
      Get.toNamed(AppRoutes.successAddPlant);
    } on Exception {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to add plant, please try again!",
        textConfirm: "OK",
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
