import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/plant_filter_search_result_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';

class PlantFilterResultWidget extends StatelessWidget {
  PlantFilterResultWidget({super.key});

  final controller = Get.put(PlantFilterSearchResultController());
  final addPlantController = Get.put(AddPlantController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: controller.searchedPlantResponse!.data!.length,
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () {
              addPlantController.selectedPlant.value = controller.searchedPlantResponse!.data![index].id!;
              Get.toNamed(AppRoutes.plantDetails);
            },
            child: SizedBox(
              height: 156,
              child: CardGlobalWidget(
                plantName: controller.searchedPlantResponse!.data![index].name!,
                plantCategory: controller
                    .searchedPlantResponse!.data![index].plantCategory!.name!,
                plantImageUrl: controller.searchedPlantResponse?.data?[index].plantImages != null &&
                      controller.searchedPlantResponse!.data![index].plantImages!.isNotEmpty
                  ? controller.searchedPlantResponse!.data![index].plantImages![0].file_name ?? ""
                  : "",
              ),
            ),
          );
        },
      ),
    );
  }
}
