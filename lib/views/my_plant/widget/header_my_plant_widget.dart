import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';

class HeaderMyPlantWidget extends StatelessWidget {
  HeaderMyPlantWidget({super.key});

  final MyPlantController myPlantController = Get.put(MyPlantController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "My Plant",
          style: TextStyleConstant.heading3.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => Text(
            '${myPlantController.listMyPlant.length} Plants',
            style: TextStyleConstant.subtitle,
          ),
        ),
      ],
    );
  }
}
