import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import 'package:plantopia/models/get_plant_by_id_response.dart';
import 'package:plantopia/models/get_plant_category_response.dart';
import 'package:plantopia/models/get_plant_recommendations_response.dart';
import 'package:plantopia/service/add_plant_service.dart';
import 'package:plantopia/service/my_plant_service.dart';
import 'package:plantopia/service/plant_details_service.dart';
import 'package:plantopia/service/watering_history_service.dart';
import 'package:plantopia/utils/status_enum_util.dart';

class MyPlantController extends GetxController {
  TextEditingController searchController = TextEditingController();
  Rx<Status> myPlantData = Status.loading.obs;
  Rx<Status> recommendationData = Status.loading.obs;
  Rx<Status> categoryData = Status.loading.obs;
  RxBool isActive = false.obs;
  RxList<PlantElement> plantCaringData = <PlantElement>[].obs;
  Rx<Status> plantCaringStatus = Status.loading.obs;
  ScrollController scrollController = ScrollController();
  RxBool showFloatingButton = true.obs;
  PlantByIdResponse? plantByIdResponse;

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
    await getMyPlant();
    getAllCategories();
    getRecommendationPlant();
    getPlantCaring();

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showFloatingButton.value = false;
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showFloatingButton.value = true; 
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

  Future<void> getPlantDetails(int plantId) async {
    try {
      plantByIdResponse = await PlantDetailsService().getPlantById(plantId);
    } catch (e) {
      return;
    }
  }

  String parseHour(String wateringSchedule) {
    DateTime time = DateFormat.Hm().parse(wateringSchedule);

    DateFormat formatter = DateFormat('hh:mm a');

    String formattedTime = formatter.format(time);

    return formattedTime;
  }

  DateTime convertToDateTime(String timeStr) {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.parse('${now.year}-${now.month}-${now.day} $timeStr');
  }

  Future<void> getPlantCaring() async {
    plantCaringStatus.value = Status.loading;
    final now = DateTime.now();
    List<PlantElement> futureSchedules = [];
    List<PlantElement> pastSchedules = [];

    if (listMyPlant.isNotEmpty) {
      for (var schedule in listMyPlant) {
        final scheduleTime = convertToDateTime(
            schedule.plant?.wateringSchedule?.wateringTime ?? "00:00");
        if (scheduleTime.isAfter(now)) {
          futureSchedules.add(schedule);
        } else {
          pastSchedules.add(schedule);
        }
      }

      futureSchedules.sort((a, b) =>
          convertToDateTime(a.plant?.wateringSchedule?.wateringTime ?? "00:00")
              .compareTo(convertToDateTime(
                  b.plant?.wateringSchedule?.wateringTime ?? "00:00")));
      pastSchedules.sort((a, b) =>
          convertToDateTime(a.plant?.wateringSchedule?.wateringTime ?? "00:00")
              .compareTo(convertToDateTime(
                  b.plant?.wateringSchedule?.wateringTime ?? "00:00")));

      plantCaringData.value = [...futureSchedules, ...pastSchedules];
      await getPlantDetails(plantCaringData[0].plant?.id ?? -1);
    }
    plantCaringStatus.value = Status.loaded;
  }

  Future<void> postWatering(int plantId) async {
    try {
      await WateringHistoryService.postWatering(plantId);
      Get.dialog(Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstant.white,
              borderRadius: BorderRadius.circular(16),
            ),
            height: 323,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(
                    ImageConstant.successWatering,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text("Hurray! 💦",
                      style: TextStyleConstant.heading4.copyWith(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Your plant has been watered!\nKeep up the good care! 🙌",
                    style: TextStyleConstant.paragraph
                        .copyWith(decoration: TextDecoration.none),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    } catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Failed to watering plant, please try again!",
        textConfirm: "OK",
        confirmTextColor: ColorConstant.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }
}
