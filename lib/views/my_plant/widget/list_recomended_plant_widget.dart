import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';

class ListRecomendedPlantWidget extends StatelessWidget {
  ListRecomendedPlantWidget({super.key});

  final MyPlantController myPlantController = Get.put(MyPlantController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: myPlantController.recommendationPlant.length,
          itemExtent: 156,
          itemBuilder: (context, int index) {
            return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: CardGlobalWidget(
                    plantName:
                        myPlantController.recommendationPlant[index].name ??
                            "-",
                    plantCategory: myPlantController
                            .recommendationPlant[index].plantCategory?.name ??
                        "-",
                    plantImageUrl: myPlantController.recommendationPlant[index]
                            .plantImages?[0].fileName ??
                        "-"));
          }),
    );
  }
}
