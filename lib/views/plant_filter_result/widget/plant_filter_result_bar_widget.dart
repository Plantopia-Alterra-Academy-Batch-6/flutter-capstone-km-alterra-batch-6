import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/search_plant_controller.dart';
import 'package:plantopia/controllers/search_plant_filter_controller.dart';
import 'package:plantopia/utils/app_routes.dart';

class PlantFilterResultBarWidget extends StatelessWidget {
  PlantFilterResultBarWidget({super.key});

  final controller = Get.put(SearchPlantFilterController());
  final addPlantController = Get.put(AddPlantController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBar(
            controller: controller.searchPlantText,
            backgroundColor: WidgetStateProperty.all(Colors.white),
            leading: SvgPicture.asset(
              IconConstant.search,
            ),
            trailing: [
              InkWell(
                onTap: () {
                  controller.searchPlantText.clear();
                },
                child: const Icon(Icons.clear, color: Colors.black),
              ),
            ],
            hintText: 'Enter search terms',
            hintStyle: WidgetStateProperty.all(
              TextStyleConstant.paragraph,
            ),
            onSubmitted: (value) {
              
            },
            elevation: WidgetStateProperty.all(0),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(
                  color: Colors.grey,
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
