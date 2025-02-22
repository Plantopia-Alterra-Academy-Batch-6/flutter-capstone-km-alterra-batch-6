import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_guide_controller.dart';
import 'package:plantopia/views/plant_guide/plant_guide_detail_view.dart';
import 'package:plantopia/views/plant_guide/widget/plant_guide_button_start_widget.dart';
import 'package:plantopia/views/plant_guide/widget/plant_guide_instruction_category_widget.dart';
import '../global_widgets/shimmer_container_global_widget.dart';

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
      backgroundColor: ColorConstant.white,
      appBar: AppBar(
        backgroundColor: ColorConstant.white,
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
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, int index) {
                double height;
                switch (index) {
                  case 0:
                    height = 25;
                    break;
                  case 1:
                    height = 75;
                    break;
                  case 2:
                    height = 65;
                    break;
                  case 3:
                    height = 65;
                    break;
                  case 4:
                    height = 65;
                    break;
                  default:
                    height = 65;
                    break;
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ShimmerContainerGlobalWidget(
                    width: double.infinity,
                    height: height,
                    radius: 5,
                  ),
                );
              },
            );
          } else if (controller.plantInstructions.isEmpty) {
            return const Center(child: Text('No instructions available'));
          } else {
            final plantInstructions = controller.plantInstructions
                .where((instruction) => instruction.plantId == plantId)
                .toList();

            final uniqueCategories = <String, dynamic>{};
            for (var instruction in plantInstructions) {
              uniqueCategories[instruction.instructionCategory?.name ?? ''] =
                  instruction;
            }
            final uniqueInstructions = uniqueCategories.values.toList();

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
                          itemCount: uniqueInstructions.length,
                          itemBuilder: (context, index) {
                            final instruction = uniqueInstructions[index];
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

                            return Obx(() {
                              final isEnabled = controller.isEnabled(index);
                              return Opacity(
                                opacity: isEnabled ? 1.0 : 0.5,
                                child: PlantGuideInstructionCategoryWidget(
                                  color: ColorConstant.white,
                                  icon: iconData,
                                  title:
                                      instruction.instructionCategory?.name ??
                                          'No Title',
                                  onTap: isEnabled
                                      ? () {
                                          final categoryInstructions =
                                              plantInstructions
                                                  .where((instr) =>
                                                      instr.instructionCategory
                                                          ?.name ==
                                                      instruction
                                                          .instructionCategory
                                                          ?.name)
                                                  .toList();

                                          Get.to(() => PlantGuideDetailView(),
                                              arguments: {
                                                'instruction': instruction,
                                                'allInstructions':
                                                    plantInstructions,
                                                'categoryInstructions':
                                                    categoryInstructions,
                                              })?.then((_) {
                                            controller.enableNextIndex(index);
                                          });
                                        }
                                      : null,
                                ),
                              );
                            });
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
       bottomNavigationBar: PlantGuideButtonStartWidget(
        onPressed: () {
          final latestEnabledIndex = controller.getLatestEnabledIndex();
          final latestInstruction = controller.plantInstructions[latestEnabledIndex];
          
          final categoryInstructions = controller.plantInstructions
              .where((instr) =>
                  instr.instructionCategory?.name ==
                  latestInstruction.instructionCategory?.name)
              .toList();

          Get.to(() => PlantGuideDetailView(), arguments: {
            'instruction': latestInstruction,
            'allInstructions': controller.plantInstructions,
            'categoryInstructions': categoryInstructions,
          });
        },
      ),
    );
  }
}