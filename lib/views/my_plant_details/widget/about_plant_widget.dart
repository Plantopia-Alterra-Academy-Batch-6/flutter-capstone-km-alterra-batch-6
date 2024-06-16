import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';

class AboutPlantWidget extends StatelessWidget {
  const AboutPlantWidget({super.key});

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
            detailMyPlant.plant?.name ?? "-",
            style: TextStyleConstant.heading3
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          detailMyPlant.plant?.description ?? "-",
          style: TextStyleConstant.paragraph,
        ),
      ],
    );
  }
}
