import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/global_widgets/card_global_widget.dart';
import 'package:plantopia/views/global_widgets/recommended_widget.dart';
import 'package:plantopia/views/my_plant/widget/empty_my_plant_widget.dart';
import 'package:plantopia/views/my_plant/widget/search_bar_widget.dart';

class MyPlantView extends StatelessWidget {
  MyPlantView({super.key}) {
    Get.lazyPut<MyPlantController>(() => MyPlantController());
  }

  @override
  Widget build(BuildContext context) {
    final MyPlantController myPlantController = Get.find<MyPlantController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Plant",
                  style: TextStyleConstant.heading3.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Obx(
                  () => Text(
                    '${myPlantController.listMyPlant.length} Plants',
                    style: TextStyleConstant.subtitle,
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                SearchBarWidget(),
                const SizedBox(
                  height: 24,
                ),
                Obx(() => _myPlantList(
                      myPlantController.myPlantData.value,
                      context,
                    )),
                const SizedBox(
                  height: 10,
                ),
                const RecommendedWidget(),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   backgroundColor: ColorConstant.primary500,
      //   label: Text(
      //     'Add Plant',
      //     style: TextStyleConstant.subtitle.copyWith(
      //       fontWeight: FontWeight.w700,
      //       color: Colors.white,
      //     ),
      //   ),
      //   icon: const Icon(
      //     Icons.add_circle_outline,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }

  Widget _myPlantList(Status status, BuildContext context) {
    final MyPlantController myPlantController = Get.find<MyPlantController>();
    switch (status) {
      case Status.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case Status.loaded:
        if (myPlantController.listMyPlant.isEmpty) {
          return const EmptyMyPlantWidget();
        } else {
          return GridView.builder(
              shrinkWrap: true,
              itemCount: myPlantController.listMyPlant.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 200,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 2),
              itemBuilder: (context, int index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.myPlantDetails, arguments: {
                      'myPlantDetails': myPlantController.listMyPlant[index]
                    })?.then((value) {
                      myPlantController.getMyPlant();
                    });
                  },
                  child: CardGlobalWidget(
                      plantName:
                          myPlantController.listMyPlant[index].plant?.name ??
                              "",
                      plantCategory: myPlantController
                              .listMyPlant[index].plant?.plantCategory?.name ??
                          "",
                      plantImageUrl: ""
                      //  myPlantController
                      //     .listMyPlant[index].plant?.plantImages?[0].fileName ?? "",
                      ),
                );
              });
        }
      case Status.error:
        return Center(
          child: Text(
            "Failed to load my plant data",
            style: TextStyleConstant.heading4.copyWith(
              color: ColorConstant.danger500,
            ),
          ),
        );
      default:
        return const EmptyMyPlantWidget();
    }
  }
}
