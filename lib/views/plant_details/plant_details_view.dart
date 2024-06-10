import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/plant_details_controller.dart';
import 'package:plantopia/views/plant_details/widget/about_plant_widget.dart';
import 'package:plantopia/views/plant_details/widget/faq_widget.dart';
import 'package:plantopia/views/plant_details/widget/image_carousel_widget.dart';
import 'package:plantopia/views/plant_details/widget/plant_care_widget.dart';
import 'package:plantopia/views/plant_details/widget/plant_characteristics_widget.dart';
import 'package:plantopia/views/plant_details/widget/plant_guide_card_widget.dart';
import 'package:plantopia/views/plant_details/widget/plant_requirements_widget.dart';

class PlantDetailsView extends StatelessWidget {
  PlantDetailsView({super.key});

  final controller = Get.put(PlantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          "Plant Details",
          style:
              TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            if (controller.isPageLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  ImageCarouselWidget(),

                  // White Container
                  Transform.translate(
                    offset: const Offset(
                        0, -30), // Moves the container up by 20 pixels
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AboutPlantWidget(),
                            PlantRequirementsWidget(),
                            PlantCharacteristicsWidget(),
                            const PlantGuideCardWidget(),
                            PlantCareWidget(),
                            FaqWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            
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
            'Add to my plants',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Button text color
            ),
          ),
        ),
      ),
    );
  }
}
