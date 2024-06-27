import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/plant_filter_search_result_controller.dart';

class SearchPlantFilterController extends GetxController {
  TextEditingController searchPlantText = TextEditingController();
  final addPlantController = Get.put(AddPlantController());
  final plantFilterSearchResultController =
      Get.put(PlantFilterSearchResultController());
  RxBool isPlantFound = false.obs;

  dynamic searchResultJson = {
    'id': 0,
    'name': '',
    'image_url': '',
    'category': '',
  };

  @override
  void onClose() {
    addPlantController.isFilterSearchResulted(false);
    super.onClose();
  }

  Future<void> searchPlant(String value) async {
    var data =
        plantFilterSearchResultController.searchedPlantResponse?.data ?? [];
    if (data.isNotEmpty) {
      for (var plant in data) {
        if (plant.name!.toLowerCase() == value.toLowerCase() ||
            plant.name!.toLowerCase().contains(value.toLowerCase()) &&
                plant.name!.toLowerCase().startsWith(value.toLowerCase())) {
          searchResultJson['id'] = plant.id;
          searchResultJson['name'] = plant.name;
          searchResultJson['image_url'] =
              plant.plantImages?.first.fileName ?? '';
          searchResultJson['category'] = plant.plantCategory!.name;
          isPlantFound(true);
        }
      }

      if (isPlantFound.isFalse) {
        plantFilterSearchResultController.isHaveResult(false);
      }
    } else {
      isPlantFound(false);
      plantFilterSearchResultController.isHaveResult(false);
    }
  }
}
