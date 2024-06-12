import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/search_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';

class SearchPlantResultWidget extends StatelessWidget {
  SearchPlantResultWidget({super.key});

  final controller = Get.put(SearchPlantController());
  final addPlantController = Get.put(AddPlantController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        addPlantController.selectedPlant(controller.searchedPlantResponse!.data!.plants!.first.id!);
        Get.toNamed(AppRoutes.plantDetails);
      },
      child: SizedBox(
        height: 200,
        width: 156,
        child: CardGlobalWidget(
          plantName: controller.searchedPlantResponse!.data!.plants!.first.name!,
          plantCategory: controller
              .searchedPlantResponse!.data!.plants!.first.plantCategory!.name!,
          plantImageUrl: controller.searchedPlantResponse!.data!.plants!.first
              .plantImages!.first.fileName!,
        ),
      ),
    );
  }
}
