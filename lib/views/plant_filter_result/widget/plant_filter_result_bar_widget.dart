import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/plant_filter_search_result_controller.dart';
import 'package:plantopia/controllers/search_plant_filter_controller.dart';
import 'package:plantopia/utils/app_routes.dart';

class PlantFilterResultBarWidget extends StatelessWidget {
  PlantFilterResultBarWidget({super.key});

  final controller = Get.put(SearchPlantFilterController());
  final addPlantController = Get.put(AddPlantController());
  final searchPlantFilterController = Get.put(SearchPlantFilterController());
  final plantFilterSearchResultController =
      Get.put(PlantFilterSearchResultController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            controller: controller.searchPlantText,
            backgroundColor: WidgetStateProperty.all(ColorConstant.white),
            leading: SvgPicture.asset(
              IconConstant.search,
            ),
            trailing: [
              InkWell(
                onTap: () {
                  controller.searchPlantText.clear();
                  searchPlantFilterController.isPlantFound(false);
                  plantFilterSearchResultController.isHaveResult(true);
                },
                child:  Icon(Icons.clear, color: ColorConstant.neutral950),
              ),
            ],
            hintText: 'Enter search terms',
            hintStyle: WidgetStateProperty.all(
              TextStyleConstant.paragraph,
            ),
            onChanged: (value) async {
              if (value.isEmpty) {
                controller.isPlantFound(false);
                searchPlantFilterController.isPlantFound(false);
                plantFilterSearchResultController.isHaveResult(true);
              } else {
                controller.isPlantFound(false);
                await controller.searchPlant(value);
              }
            },
            onSubmitted: (value) async {
              await controller.searchPlant(value);
            },
            elevation: WidgetStateProperty.all(0),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side:  BorderSide(
                  color: ColorConstant.neutral400,
                  width: 0.3,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 20,
          height: 20,
          child: InkWell(
            borderRadius: BorderRadius.circular(180),
            onTap: () {
              Get.toNamed(AppRoutes.plantFilter);
            },
            child: SvgPicture.asset(
              IconConstant.filter,
            ),
          ),
        ),
      ],
    );
  }
}
