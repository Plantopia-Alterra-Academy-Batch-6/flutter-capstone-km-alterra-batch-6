import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/notification_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/notification/widget/bottom_sheet2_widget.dart';
import 'package:plantopia/views/notification/widget/bottom_sheet3_widget.dart';
import 'package:plantopia/views/notification/widget/button_widget.dart';

class BottomSheet1Widget extends StatelessWidget {
  BottomSheet1Widget({super.key, required this.notifId});

  final int notifId;

  final NotificationController notifController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        height: 448,
        child: Obx(
          () => switch (notifController.plantStatus.value) {
            Status.loading => Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.primary500,
                ),
              ),
            Status.loaded => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 36,
                        ),
                      ),
                    ),
                    Container(
                      color: ColorConstant.neutral50,
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              ImageConstant.plantDummy,
                              width: 150,
                              height: 160,
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tomato",
                                style: TextStyleConstant.heading4.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Solanacae",
                                style: TextStyleConstant.caption
                                    .copyWith(color: ColorConstant.neutral400),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Watering Schedule",
                                style: TextStyleConstant.caption
                                    .copyWith(color: ColorConstant.neutral500),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "08:00 AM",
                                style: TextStyleConstant.caption,
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Your tomato is thirsty...",
                      style: TextStyleConstant.subtitle,
                    ),
                    Text(
                      "How if we give it some water now?",
                      style: TextStyleConstant.subtitle,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ButtonWidget(
                              buttonName: "Edit Schedule",
                              boxDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: ColorConstant.primary500,
                                ),
                              ),
                              textStyle: TextStyleConstant.subtitle.copyWith(
                                color: ColorConstant.primary500,
                              ),
                              onTap: () {
                                Get.bottomSheet(BottomSheet2Widget());
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: ButtonWidget(
                            buttonName: "Watered",
                            boxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorConstant.primary500,
                            ),
                            textStyle: TextStyleConstant.subtitle.copyWith(
                              color: Colors.white,
                            ),
                            onTap: () async {
                              while (Get.isBottomSheetOpen == true) {
                                Get.back();
                              }
                              await notifController
                                  .getNotificationById(notifId);
                              await Get.bottomSheet(const BottomSheet3Widget());
                              await notifController.getAllNotification();
                            },
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            Status.error => Center(
                child: Text(
                  "Failed to get notification details",
                  style: TextStyleConstant.heading4.copyWith(
                    color: ColorConstant.danger500,
                  ),
                ),
              ),
          },
        ));
  }
}
