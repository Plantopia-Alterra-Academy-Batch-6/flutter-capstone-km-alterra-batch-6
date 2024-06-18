import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/add_plant_controller.dart';
import 'package:plantopia/controllers/plant_filter_controller.dart';
import 'package:plantopia/controllers/plant_filter_search_result_controller.dart';
import 'package:plantopia/controllers/search_plant_filter_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/plant_filter/widget/plant_category_widget.dart';
import 'package:plantopia/views/plant_filter/widget/plant_harvest_duration_widget.dart';
import 'package:plantopia/views/plant_filter/widget/plant_sunlight_req_widget.dart';
import 'package:plantopia/views/plant_filter/widget/plant_toxicity_widget.dart';

class PlantFilterView extends StatelessWidget {
  PlantFilterView({super.key});

  final addPlantController = Get.put(AddPlantController());
  final plantFilterSearchResultController =
      Get.put(PlantFilterSearchResultController());
  final controller = Get.put(PlantFilterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Plant Filter",
              style: TextStyleConstant.heading4
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlantCategoryWidget(),
              const SizedBox(height: 32),
              PlantSunlightReqWidget(),
              const SizedBox(height: 32),
              PlantHarvestDurationWidget(),
              const SizedBox(height: 32),
              PlantToxicityWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 76, // Ensure the height is appropriate for visibility
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () async {
              String plantCategory;
              if (controller.selectedCategory.value == 0) {
                plantCategory = '';
              } else {
                plantCategory = controller.selectedCategory.value.toString();
              }
              await controller.createQueryParams();
              plantFilterSearchResultController.updateQuery(plantCategory);

              print(addPlantController.isFilterSearchResulted.value);
              if (addPlantController.isFilterSearchResulted.isTrue) {
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                print("true");
              } else {
                print("false");
                addPlantController.isFilterSearchResulted(true);
                Get.offNamed(AppRoutes.plantFilterResult);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  ColorConstant.primary500, // Button background color
              fixedSize: const Size(double.infinity, 60), // Button size
              padding: const EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Show result',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Button text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
