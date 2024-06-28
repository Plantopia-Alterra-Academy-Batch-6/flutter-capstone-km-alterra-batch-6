import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_plant_category_response.dart';
import 'package:plantopia/models/get_plant_recommendations_response.dart';
import 'package:plantopia/service/add_plant_service.dart';

class AddPlantController extends GetxController {
  RxBool isPageLoading = true.obs;

  AddPlantService addPlantService = AddPlantService();
  PlantCategoriesResponse? plantCategoriesResponse;
  PlantRecommendationsResponse? plantRecommendationsResponse;
  RxInt selectedPlant = 0.obs;
  RxBool isFilterSearchResulted = false.obs;

  @override
  void onInit() {
    initAddPlantPage();
    super.onInit();
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

  Future<void> initAddPlantPage() async {
    isPageLoading(true);
    try {
      plantCategoriesResponse = await addPlantService.getAllPlantCategory();
      plantRecommendationsResponse =
          await addPlantService.getPlantRecommendations();
      isPageLoading(false);
    } on Exception {
      Get.back(canPop: true);
      Get.defaultDialog(
        title: "Network Error Occured!",
        titleStyle: TextStyleConstant.heading4,
        middleText:
            "Please check your internet connection, or contact the developers if this issue still exist!",
        middleTextStyle: TextStyleConstant.paragraph,
        textConfirm: "OK",
        confirmTextColor: ColorConstant.white,
        buttonColor: ColorConstant.primary500,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
