import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';

class PlantHistoryWidget extends StatelessWidget {
  PlantHistoryWidget({super.key});

  final MyPlantDetailsController myPlantDetailsController =
      Get.put(MyPlantDetailsController());

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    final PlantElement detailMyPlant = arguments['myPlantDetails'];
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconConstant.calendar,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Planting Date",
                    style: TextStyleConstant.paragraph.copyWith(
                      color: ColorConstant.neutral500,
                    ),
                  )
                ],
              ),
            ),
            Text(
              myPlantDetailsController.parseDate(
                detailMyPlant.createdAt ??
                    DateTime(
                      0,
                    ),
              ),
              style: TextStyleConstant.paragraph.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconConstant.potPlant,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Planting Age",
                    style: TextStyleConstant.paragraph.copyWith(
                      color: ColorConstant.neutral500,
                    ),
                  )
                ],
              ),
            ),
            Text(
              myPlantDetailsController
                  .plantAge(detailMyPlant.createdAt ?? DateTime(0)),
              style: TextStyleConstant.paragraph.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconConstant.waterDrop,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Watering Time",
                    style: TextStyleConstant.paragraph.copyWith(
                      color: ColorConstant.neutral500,
                    ),
                  )
                ],
              ),
            ),
            Text(
              myPlantDetailsController.parseHour(
                  detailMyPlant.plant?.wateringSchedule?.wateringTime ??
                      "00.00"),
              style: TextStyleConstant.paragraph.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
