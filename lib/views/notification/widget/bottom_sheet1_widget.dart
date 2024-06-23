import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/notification_controller.dart';
import 'package:plantopia/utils/status_enum_util.dart';
import 'package:plantopia/views/notification/widget/bottom_sheet2_widget.dart';
import 'package:plantopia/views/notification/widget/bottom_sheet3_widget.dart';
import 'package:plantopia/views/notification/widget/button_widget.dart';

class BottomSheet1Widget extends StatelessWidget {
  BottomSheet1Widget(
      {super.key, required this.notifId, required this.messages});
  final int notifId;
  final String messages;

  final NotificationController notifController = Get.find();

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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: notifController.plantByIdResponse
                                        ?.data?.plantImages?[0].fileName ??
                                    "-",
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notifController.extractPlantName(notifController
                                        .plantByIdResponse?.data?.name ??
                                    "-"),
                                style: TextStyleConstant.heading4.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                notifController.extractFamilyName(
                                    notifController
                                            .plantByIdResponse?.data?.name ??
                                        "-"),
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
                                notifController.parseHour(notifController
                                        .plantByIdResponse
                                        ?.data
                                        ?.wateringSchedule
                                        ?.wateringTime ??
                                    ""),
                                style: TextStyleConstant.caption.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
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
                      messages,
                      style: TextStyleConstant.subtitle,
                      textAlign: TextAlign.center,
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
                                Get.bottomSheet(
                                    BottomSheet2Widget(
                                      notifId: notifId,
                                    ),
                                    isDismissible: false);
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
                              Get.bottomSheet(const BottomSheet3Widget());
                              await notifController
                                  .getNotificationById(notifId);
                              await notifController.postWatering(
                                  notifController.plantByIdResponse?.data?.id ??
                                      -1);
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
