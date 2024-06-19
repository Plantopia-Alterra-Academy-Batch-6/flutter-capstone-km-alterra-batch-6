import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';

class SingleResultWidget extends StatelessWidget {
  SingleResultWidget({super.key});

  final MyPlantController myPlantController = Get.put(MyPlantController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: 16, bottom: 10),
      child: GestureDetector(
        onTap: () {
        },
        child: SizedBox(
          height: 200,
          width: 156,
          child: CardGlobalWidget(
            plantName:
                myPlantController.searchResultJson['customize_name'] != ""
                    ? myPlantController.searchResultJson['customize_name']
                    : myPlantController.searchResultJson['name'],
            plantCategory: myPlantController.searchResultJson['category'],
            plantImageUrl:
                myPlantController.searchResultJson['image_url'] ?? "",
          ),
        ),
      ),
    );
  }
}
