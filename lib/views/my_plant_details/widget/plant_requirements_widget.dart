import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_my_plant_response_model.dart';

class PlantRequirementsWidget extends StatelessWidget {
  const PlantRequirementsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Map arguments = Get.arguments;
    final PlantElement detailMyPlant = arguments['detailPlant'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          "Plant requirements",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(width: 0.3),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              ListTile(
                leading: SvgPicture.asset('assets/icons/plant_climate.svg'),
                title: Text(
                  "Climate",
                  style: TextStyleConstant.subtitle
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                trailing: Text(
                  detailMyPlant.plant?.climateCondition ?? "-",
                  style: TextStyleConstant.subtitle
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                color: ColorConstant.primary50,
                child: ListTile(
                  leading: SvgPicture.asset('assets/icons/plant_sunlight.svg'),
                  title: Text(
                    "Sunlight",
                    style: TextStyleConstant.subtitle
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  trailing: Text(
                    detailMyPlant.plant?.sunlight ?? "-",
                    style: TextStyleConstant.subtitle
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset('assets/icons/plant_type.svg'),
                title: Text(
                  "Type",
                  style: TextStyleConstant.subtitle
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                trailing: Text(
                  detailMyPlant.plant?.isToxic != null
                      ? 'Toxic'
                      : 'Non-Toxic' ,
                  style: TextStyleConstant.subtitle
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                color: ColorConstant.primary50,
                child: ListTile(
                  leading:
                      SvgPicture.asset('assets/icons/plant_planting_time.svg'),
                  title: Text(
                    "Planting Time",
                    style: TextStyleConstant.subtitle
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  trailing: Text(
                    detailMyPlant.plant?.plantingTime ?? "-",
                    style: TextStyleConstant.subtitle
                        .copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              ListTile(
                leading:
                    SvgPicture.asset('assets/icons/plant_harvest_time.svg'),
                title: Text(
                  "Harvest Time",
                  style: TextStyleConstant.subtitle
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                trailing: Text(
                  '${(detailMyPlant.plant!.harvestDuration! / 30).truncate()} Months',
                  style: TextStyleConstant.subtitle
                      .copyWith(fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
