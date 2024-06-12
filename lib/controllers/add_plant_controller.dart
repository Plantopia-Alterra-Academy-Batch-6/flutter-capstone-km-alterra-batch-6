import 'package:get/get.dart';
import 'package:plantopia/models/get_plant_category_response.dart';
import 'package:plantopia/models/get_plant_recommendations_response.dart';
import 'package:plantopia/service/add_plant_service.dart';

class AddPlantController extends GetxController {
  RxBool isPageLoading = true.obs;

  AddPlantService addPlantService = AddPlantService();
  PlantCategoriesResponse? plantCategoriesResponse;
  PlantRecommendationsResponse? plantRecommendationsResponse;
  RxInt selectedPlant = 0.obs;

  @override
  void onInit() {
    initAddPlantPage();
    super.onInit();
  }

  Future<void> initAddPlantPage() async {
    isPageLoading(true);
    plantCategoriesResponse = await addPlantService.getAllPlantCategory();
    plantRecommendationsResponse = await addPlantService.getPlantRecommendations();
    isPageLoading(false);
  }

}