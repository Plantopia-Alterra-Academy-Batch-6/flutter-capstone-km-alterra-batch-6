import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';

class AboutPlantWidget extends StatelessWidget {
  AboutPlantWidget({super.key});

  final MyPlantDetailsController myPlantDetailsController =
      Get.put(MyPlantDetailsController());

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    final PlantElement detailMyPlant = arguments['myPlantDetails'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Center(
          child: Text(
            (detailMyPlant.plant?.name ?? "-"),
            style: TextStyleConstant.heading3
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          myPlantDetailsController
              .filterHtmlTag(detailMyPlant.plant?.description ?? "-"),
          style: TextStyleConstant.paragraph,
        ),
      ],
    );
  }
}
