

import 'package:get/get.dart';
import 'package:plantopia/controllers/search_plant_controller.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';
import 'package:plantopia/service/plant_details_service.dart';

class PlantDetailsController extends GetxController {
  final searchPlantController = Get.put(SearchPlantController());
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
    plantByIdResponse = await plantDetailsService.getPlantById(searchPlantController.searchedPlantId.value);
    isPageLoading(false);
  }
}