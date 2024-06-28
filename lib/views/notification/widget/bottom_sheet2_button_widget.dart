import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/notification_controller.dart';
import 'package:plantopia/views/my_plant_details/widget/button_widget.dart';

class BottomSheet2ButtonWidget extends StatelessWidget {
  BottomSheet2ButtonWidget({super.key, required this.notifId});

  final int notifId;
    final NotificationController notifController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ButtonWidget(
          onTap: () {
            Get.back();
          },
          buttonName: "Cancel",
          boxDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: ColorConstant.primary500,
            ),
          ),
          textStyle: TextStyleConstant.subtitle
              .copyWith(color: ColorConstant.primary500),
        )),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: ButtonWidget(
            onTap: () async {
              await notifController.getNotificationById(notifId);
              await notifController.customizeWateringReminder(
                  notifController.plantByIdResponse?.data?.id ?? -1,
                  notifController.formatTime(notifController.dateTime.value),
                  notifController.selectedOption.value,
                  notifController
                          .plantByIdResponse?.data?.wateringSchedule?.each ??
                      "-");
              while (Get.isBottomSheetOpen == true) {
                Get.back();
              }
              final snackBar = SnackBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    6,
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                backgroundColor: ColorConstant.primary500,
                content: Text(
                  'Watering will be reminded in ${notifController.snackBarReminder(
                    notifController.dateTime.value,
                  )}',
                  style: TextStyleConstant.paragraph.copyWith(
                    color: ColorConstant.white,
                  ),
                ),
                action: SnackBarAction(
                  label: '',
                  onPressed: () {},
                ),
              );
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            buttonName: "Save",
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: ColorConstant.primary500,
            ),
            textStyle: TextStyleConstant.subtitle.copyWith(color: ColorConstant.white),
          ),
        ),
      ],
    );
  }
}
