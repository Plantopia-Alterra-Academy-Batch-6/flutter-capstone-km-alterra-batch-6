import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/models/get_my_plant_response_model_new.dart';
import 'package:plantopia/views/plant_guide/widget/plant_guide_button_end_widget.dart';
import 'package:plantopia/views/plant_guide/widget/plant_guide_instruction_detail_widget.dart';

class PlantGuideDetailView extends StatelessWidget {
  PlantGuideDetailView({super.key});

  final PlantInstruction instruction = Get.arguments['instruction'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          instruction.instructionCategory?.name ?? 'No Title',
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: PlantGuideInstructionDetailWidget(
            categoryDescription: instruction.instructionCategory?.description ??
                'No Description',
            categoryTitle: instruction.instructionCategory?.name ?? 'No Title',
            imageUrl: instruction.stepImageUrl ?? '',
            stepNumber: instruction.stepNumber ?? 0,
            stepTitle: instruction.stepTitle ?? 'No Title',
            stepDescription: instruction.stepDescription ?? 'No Description',
          ),
        ),
      ),
      bottomNavigationBar: const PlantGuideButtonEndWidget(),
    );
  }
}
