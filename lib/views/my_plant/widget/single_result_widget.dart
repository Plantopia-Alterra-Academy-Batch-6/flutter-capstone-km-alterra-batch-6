import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/my_plant/widget/card_my_plant_widget.dart';

class SingleResultWidget extends StatelessWidget {
  SingleResultWidget({super.key});

  final MyPlantController myPlantController = Get.put(MyPlantController());

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: myPlantController.searchMyPlant.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 200,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          crossAxisCount: 2),
      itemBuilder: (context, int index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.myPlantDetails, arguments: {
              'myPlantDetails': myPlantController.searchMyPlant[index]
            });
          },
          child: SizedBox(
            height: 200,
            width: 156,
            child: CardMyPlantWidget(
              plantName: myPlantController.searchMyPlant[index].customizeName !=
                      ""
                  ? myPlantController.extractPlantName(
                      myPlantController.searchMyPlant[index].customizeName ??
                          "-")
                  : myPlantController.extractPlantName(
                      myPlantController.searchMyPlant[index].plant?.name ??
                          "-"),
              plantCategory: myPlantController.extractFamilyName(
                  myPlantController.searchMyPlant[index].plant?.name ?? "-"),
              plantImageUrl: myPlantController
                      .searchMyPlant[index].plant?.plantImages?[0].fileName ??
                  "-",
            ),
          ),
        );
      },
    );
  }
}