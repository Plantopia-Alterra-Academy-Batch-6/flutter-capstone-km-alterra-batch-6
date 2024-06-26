import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/my_plant_details_controller.dart';
import 'package:plantopia/views/global_widgets/bottom_navigation_bar_global_widget.dart';
import 'package:plantopia/views/my_plant_details/widget/button_widget.dart';

class EditPlantNameWidget extends StatelessWidget {
  EditPlantNameWidget({super.key, required this.plantId});
  final int plantId;

  final MyPlantDetailsController myPlantDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ButtonWidget(
        buttonName: "Edit Plant",
        boxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorConstant.primary500,
        ),
        textStyle: TextStyleConstant.subtitle.copyWith(color: Colors.white),
        onTap: () {
          Get.dialog(
            Center(
              child: Dialog(
                backgroundColor: ColorConstant.white,
                insetPadding: const EdgeInsets.all(16),
                child: Container(
                  height: 230,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      Text(
                        "Edit Name Plant",
                        style: TextStyleConstant.heading4.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller:
                            myPlantDetailsController.changeNameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter plant name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonWidget(
                                onTap: () {
                                  Get.back();
                                },
                                buttonName: "Cancel",
                                boxDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorConstant.white,
                                ),
                                textStyle: TextStyleConstant.title.copyWith(
                                  color: ColorConstant.danger500,
                                )),
                          ),
                          Expanded(
                            child: ButtonWidget(
                              onTap: () async {
                                if (myPlantDetailsController
                                    .changeNameController.text.isNotEmpty) {
                                  await myPlantDetailsController
                                      .createCustomizeName(
                                          plantId,
                                          myPlantDetailsController
                                              .changeNameController.text);
                                  Get.offAll(
                                    () => const BottomNavigationBarGlobalWidget(
                                      index: 2,
                                    ),
                                  );
                                } else {
                                  Get.defaultDialog(
                                      title: "Warning",
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 16),
                                      confirm: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 16),
                                        child: ButtonWidget(
                                          onTap: () {
                                            Get.back();
                                          },
                                          buttonName: "Ok",
                                          boxDecoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: ColorConstant.primary500),
                                          textStyle:
                                              TextStyleConstant.title.copyWith(
                                            color: ColorConstant.white,
                                          ),
                                        ),
                                      ),
                                      titlePadding: const EdgeInsets.fromLTRB(
                                          16, 16, 16, 0),
                                      titleStyle: TextStyleConstant.heading4
                                          .copyWith(
                                              fontWeight: FontWeight.w700),
                                      content: Text(
                                        "Edit plant name cannot be empty",
                                        style: TextStyleConstant.heading4,
                                      ));
                                }
                              },
                              buttonName: "Save",
                              boxDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorConstant.primary500,
                              ),
                              textStyle: TextStyleConstant.title.copyWith(
                                color: ColorConstant.white,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
