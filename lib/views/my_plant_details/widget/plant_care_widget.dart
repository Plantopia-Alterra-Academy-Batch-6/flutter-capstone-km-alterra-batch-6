import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';

class PlantCareWidget extends StatelessWidget {
  PlantCareWidget({super.key});

  final MyPlantDetailsController myPlantDetailsController =
      Get.put(MyPlantDetailsController());

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    final PlantElement detailMyPlant = arguments['myPlantDetails'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          "Plant Care",
          style: TextStyleConstant.heading4.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          myPlantDetailsController
              .filterHtmlTag(detailMyPlant.plant?.additionalTips ?? "-"),
        )
      ],
    );
  }
}
