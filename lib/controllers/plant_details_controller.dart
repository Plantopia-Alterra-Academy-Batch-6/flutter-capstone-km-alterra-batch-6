import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';
import 'package:plantopia/service/plant_details_service.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;

class PlantDetailsController extends GetxController {
  final addPlantController = Get.put(AddPlantController());
  final myPlantController = Get.put(MyPlantController());
  PlantDetailsService plantDetailsService = PlantDetailsService();
  PlantByIdResponse? plantByIdResponse;
  RxBool isPageLoading = false.obs;
  RxBool isDataError = false.obs;
  RxInt activeIndex = 0.obs;
  RxBool customIcon = false.obs;

  @override
  void onInit() {
    getPlantDetails();
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

  String filterHtmlTag(String htmlString) {
    dom.Document document = html_parser.parse(htmlString);
    return document.body?.text ?? '';
  }

  void getPlantDetails() async {
    try {
      isPageLoading(true);
      plantByIdResponse = await plantDetailsService
          .getPlantById(addPlantController.selectedPlant.value);
      isPageLoading(false);
      isDataError(false);
    } on Exception {
      isDataError(true);
      isPageLoading(false);
    }
  }

  Future<void> addPlant(int id) async {
    try {
      await plantDetailsService.addPlant(id);
      await myPlantController.getMyPlant();
      Get.toNamed(AppRoutes.successAddPlant);
    } on Exception {
      Get.defaultDialog(
        title: "Error",
        titleStyle: TextStyleConstant.heading4,
        middleText: "Failed to add plant, please try again!",
        middleTextStyle: TextStyleConstant.paragraph,
        textConfirm: "OK",
        buttonColor: ColorConstant.primary500,
        confirmTextColor: ColorConstant.white,
        onConfirm: () {
          Get.back(canPop: true);
        },
      );
    }
  }
}
