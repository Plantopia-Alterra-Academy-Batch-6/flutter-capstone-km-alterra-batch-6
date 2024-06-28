import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/views/my_plant_details/widget/button_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/confirmation_dialog_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/edit_plant_name_widget.dart';

class BottomSheetDeleteWidget extends StatelessWidget {
  BottomSheetDeleteWidget({super.key, required this.plantId});
  final int plantId;

  final MyPlantDetailsController myPlantDetailsController =
      Get.put(MyPlantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      height: 307,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.asset(
              ImageConstant.confirmation,
              width: 97,
              height: 97,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                width: double.infinity,
                child: Text(
                  "Select one of the following options\n to customize your plants",
                  style: TextStyleConstant.title.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ButtonWidget(
                      buttonName: "Delete Plant",
                      boxDecoration: const BoxDecoration(),
                      textStyle: TextStyleConstant.subtitle.copyWith(
                          color: ColorConstant.danger500,
                          fontWeight: FontWeight.w700),
                      onTap: () {
                        Get.back();
                        Get.dialog(ConfirmationDialogWidget(
                          plantId: plantId,
                        ));
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  EditPlantNameWidget(
                    plantId: plantId,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
