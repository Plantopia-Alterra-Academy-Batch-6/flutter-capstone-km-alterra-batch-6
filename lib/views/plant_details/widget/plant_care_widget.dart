import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_details_controller.dart';

class PlantCareWidget extends StatelessWidget {
  PlantCareWidget({super.key});

  final controller = Get.put(PlantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          "Plant Care",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: SvgPicture.asset(
            'assets/icons/plant_watering_recommendation.svg',
            width: 38,
            height: 32,
          ),
          title: Text(
            "Watering Recommendations",
            style: TextStyleConstant.title.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          "Belum ada data nya ges",
          style: TextStyleConstant.paragraph,
        ),
        const SizedBox(height: 10),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: SvgPicture.asset(
            'assets/icons/plant_soil_recommendation.svg',
            width: 38,
            height: 32,
          ),
          title: Text(
            "Soil Recommendations",
            style: TextStyleConstant.title.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          "Belum ada data nya ges",
          style: TextStyleConstant.paragraph,
        ),
        const SizedBox(height: 10),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: SvgPicture.asset(
            'assets/icons/plant_fertilizer_amount.svg',
            width: 38,
            height: 32,
          ),
          title: Text(
            "Fertilizer Amount",
            style: TextStyleConstant.title.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          "Belum ada data nya ges",
          style: TextStyleConstant.paragraph,
        ),
        const SizedBox(height: 10),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: SvgPicture.asset(
            'assets/icons/plant_pests_control.svg',
            width: 38,
            height: 32,
          ),
          title: Text(
            "How to deal with pests",
            style: TextStyleConstant.title.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          "Belum ada data nya ges",
          style: TextStyleConstant.paragraph,
        ),
      ],
    );
  }
}
