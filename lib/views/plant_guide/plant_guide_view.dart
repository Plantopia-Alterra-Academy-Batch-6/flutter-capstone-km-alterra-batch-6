import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_guide_controller.dart';
import 'package:plantopia/views/plant_guide/plant_guide_detail_view.dart';
import 'package:plantopia/views/plant_guide/widget/plant_guide_button_start_widget.dart';
import 'package:plantopia/views/plant_guide/widget/plant_guide_instruction_category_widget.dart';

class PlantGuideView extends StatelessWidget {
  PlantGuideView({super.key});

  final int plantId = Get.arguments['plantId'];

  @override
  Widget build(BuildContext context) {
    final GetMyPlantGuideController controller =
        Get.put(GetMyPlantGuideController());

    if (kDebugMode) {
      print('plant id $plantId');
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Planting Guide',
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.plantInstructions.isEmpty) {
            return const Center(child: Text('No instructions available'));
          } else {
            final plantInstructions = controller.plantInstructions
                .where((instruction) => instruction.plantId == plantId)
                .toList();
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Introduction',
                          style: TextStyleConstant.heading4
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Welcome to Planting Guide! Learn how to prepare the soil for optimal growth, plant seeds effectively, care for your plants with expert tips, and harvest properly. Sow dreams and harvest inspiration. Happy gardening!',
                          style: TextStyleConstant.paragraph,
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: plantInstructions.length,
                          itemBuilder: (context, index) {
                            final instruction = plantInstructions[index];
                            String iconData;
                            switch (instruction.instructionCategory?.name) {
                              case 'Soil Preparation':
                                iconData = IconConstant.soilPreparation;
                                break;
                              case 'Planting Seeds':
                                iconData = IconConstant.plantingSeeds;
                                break;
                              case 'Plant Care':
                                iconData = IconConstant.plantCare;
                                break;
                              case 'Harvest':
                                iconData = IconConstant.harvest;
                                break;
                              default:
                                iconData = IconConstant.help;
                            }

                            if (kDebugMode) {
                              print(instruction.stepDescription);
                            }

                            return PlantGuideInstructionCategoryWidget(
                              icon: iconData,
                              title: instruction.instructionCategory?.name ??
                                  'No Title',
                              onTap: () {
                                Get.to(() => PlantGuideDetailView(),
                                    arguments: {'instruction': instruction});
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
        
      ),
      bottomNavigationBar: const PlantGuideButtonStartWidget(),
    );
  }
}
