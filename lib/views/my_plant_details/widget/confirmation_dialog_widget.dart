import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_bar_global_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/button_widget.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  ConfirmationDialogWidget({super.key, required this.plantId});
  final int plantId;

  final MyPlantDetailsController myPlantDetailsController =
      Get.put(MyPlantDetailsController());

  final MyPlantController myPlantController = Get.put(MyPlantController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            height: 380,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                16,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    IconConstant.confirmation,
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Are You Sure You Want to Delete Plant Data?",
                          style: TextStyleConstant.heading4.copyWith(
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  const SizedBox(
                    height: 4,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "All of the information will be erased and cannot be restored",
                          style: TextStyleConstant.paragraph.copyWith(
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                          onTap: () async {
                            Get.back();
                          },
                          buttonName: "Cancel",
                          boxDecoration:
                              const BoxDecoration(color: Colors.white),
                          textStyle: TextStyleConstant.subtitle.copyWith(
                              color: ColorConstant.primary500,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: ButtonWidget(
                          onTap: () {
                            myPlantDetailsController.deleteMyplant(plantId);
                            myPlantController.init();
                            Get.offAll(
                              const BottomNavigationBarGlobalWidget(
                                index: 2,
                              ),
                            );
                          },
                          buttonName: "Delete",
                          boxDecoration: BoxDecoration(
                            color: ColorConstant.danger500,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          textStyle: TextStyleConstant.subtitle.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            )),
      ),
    );
  }
}
