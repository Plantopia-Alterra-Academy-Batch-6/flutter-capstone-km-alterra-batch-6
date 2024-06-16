import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';

class SearchPlantFilterController extends GetxController {
  TextEditingController searchPlantText = TextEditingController();
  final addPlantController = Get.put(AddPlantController());

  @override
  void onClose() {
    addPlantController.isFilterSearchResulted(false);
    super.onClose();
  }
}