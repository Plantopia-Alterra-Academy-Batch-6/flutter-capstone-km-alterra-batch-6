import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/search_plant_filter_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';

class PlantFilterSingleResultWidget extends StatelessWidget {
  PlantFilterSingleResultWidget({super.key});

  final controller = Get.put(SearchPlantFilterController());
  final addPlantController = Get.put(AddPlantController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addPlantController.selectedPlant.value =
            controller.searchResultJson['id'];
        Get.toNamed(AppRoutes.plantDetails);
      },
      child: SizedBox(
        height: 200,
        width: 156,
        child: CardGlobalWidget(
          plantName: addPlantController
              .extractPlantName(controller.searchResultJson['name']),
          plantCategory: addPlantController
              .extractFamilyName(controller.searchResultJson['name']),
          plantImageUrl: controller.searchResultJson['image_url'] ?? "",
        ),
      ),
    );
  }
}
