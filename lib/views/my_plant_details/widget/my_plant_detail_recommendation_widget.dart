import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/controllers/recomendation_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';
import 'package:loading_indicator/loading_indicator.dart';

class MyPlantDetailRecommendationWidget extends StatelessWidget {
  const MyPlantDetailRecommendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPlantDetailsController myPlantDetailsController =
        Get.put(MyPlantDetailsController());
    final RecomendationController recomendationController =
        Get.put(RecomendationController());
    final Map arguments = Get.arguments;
    final PlantElement detailMyPlant = arguments['myPlantDetails'];
    String plantName = detailMyPlant.customizeName != ""
        ? myPlantDetailsController
            .extractPlantName(detailMyPlant.customizeName ?? "-")
        : myPlantDetailsController
            .extractPlantName(detailMyPlant.plant?.name ?? "-");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      recomendationController.getRecommendations(plantName);
      recomendationController.getArticles(plantName);
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommendation safe pest',
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (recomendationController.recommendationLoading.value) {
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  colors: [ColorConstant.primary500],
                  strokeWidth: 1,
                ),
              ),
            );
          } else {
            return Text(
              myPlantDetailsController.filterHtmlTag(
                  recomendationController.responseText.value),
              style: TextStyleConstant.paragraph,
            );
          }
        }),
        const SizedBox(height: 8),
        Text(
          'Article farming practice',
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (recomendationController.articleLoading.value) {
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse,
                  colors: [ColorConstant.primary500],
                  strokeWidth: 1,
                ),
              ),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recomendationController.parseAndBuildArticles(
                  recomendationController.articleResponseText.value),
            );
          }
        }),
      ],
    );
  }
}
