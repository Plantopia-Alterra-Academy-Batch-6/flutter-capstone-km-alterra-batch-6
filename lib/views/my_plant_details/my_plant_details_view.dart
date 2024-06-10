import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/views/my_plant_details/widget/about_plant_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/faq_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/image_carousel_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_care_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_characteristics_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_guide_card_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/plant_requirements_widget.dart';

class MyPlantDetailsView extends StatelessWidget {
  const MyPlantDetailsView({super.key});

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
            return Column(
              children: [
                ImageCarouselWidget(),
                Transform.translate(
                  offset: const Offset(0, -30),
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
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    ColorConstant.primary500, // Button background color
                fixedSize: const Size(100, 60), // Button size
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
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    ColorConstant.primary500, // Button background color
                fixedSize: const Size(100, 60), // Button size
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
          ],
        ),
      ),
    );
  }
}
