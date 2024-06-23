import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_details_controller.dart';

class PlantCharacteristicsWidget extends StatelessWidget {
  PlantCharacteristicsWidget({super.key});

  final controller = Get.put(PlantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          "Characteristics",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Text(
            "Height",
            style: TextStyleConstant.subtitle.copyWith(
                fontWeight: FontWeight.w400, color: ColorConstant.neutral500),
          ),
          trailing: Text(
            '${controller.plantByIdResponse!.data!.plantCharacteristic!.height} meter',
            style: TextStyleConstant.subtitle
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Divider(
          color: ColorConstant.neutral300,
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Text(
            "Wide",
            style: TextStyleConstant.subtitle.copyWith(
                fontWeight: FontWeight.w400, color: ColorConstant.neutral500),
          ),
          trailing: Text(
            '${controller.plantByIdResponse!.data!.plantCharacteristic!.wide!} cm',
            style: TextStyleConstant.subtitle
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Divider(
          color: ColorConstant.neutral300,
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Text(
            "Leaf Color",
            style: TextStyleConstant.subtitle.copyWith(
                fontWeight: FontWeight.w400, color: ColorConstant.neutral500),
          ),
          trailing: Text(
            controller.plantByIdResponse!.data!.plantCharacteristic!.leafColor!,
            style: TextStyleConstant.subtitle
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
