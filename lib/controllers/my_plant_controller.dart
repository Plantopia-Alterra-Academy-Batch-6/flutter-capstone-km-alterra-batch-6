import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import 'package:plantopia/service/my_plant_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class MyPlantController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<Status> myPlantData = Status.loading.obs;
  RxList<PlantElement> listMyPlant = <PlantElement>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMyPlant();
  }

  void getMyPlant() async {
    try {
      myPlantData.value = Status.loading;
      final response = await MyPlantService.getMyPlant();
      listMyPlant.value = response.data?.plants ?? [];
      myPlantData.value = Status.loaded;
    } catch (e) {
      myPlantData.value = Status.error;
    }
  }
}
