import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/notification_controller.dart';
import 'package:plantopia/views/notification/widget/button_widget.dart';

class BottomSheet2Widget extends StatelessWidget {
  BottomSheet2Widget({super.key});

  final NotificationController notifController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      width: double.infinity,
      height: 448,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  ImageConstant.plantDummy,
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tomato",
                        style: TextStyleConstant.subtitle,
                      ),
                      Text(
                        "Default reminder : 08.00 am",
                        style: TextStyleConstant.caption
                            .copyWith(color: ColorConstant.neutral500),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  color: ColorConstant.neutral50,
                  borderRadius: BorderRadius.circular(16)),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reminder Setting",
                    style: TextStyleConstant.paragraph,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Schedule watering for later",
                    style: TextStyleConstant.caption
                        .copyWith(color: ColorConstant.neutral500),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TimePickerSpinner(
                    isForce2Digits: true,
                    is24HourMode: true,
                    normalTextStyle: TextStyleConstant.paragraph.copyWith(
                      color: ColorConstant.neutral400,
                    ),
                    minutesInterval: 15,
                    highlightedTextStyle: TextStyleConstant.heading3,
                    spacing: 32,
                    itemHeight: 30,
                    itemWidth: 30,
                    onTimeChange: (time) {},
                  ),
                ],
              ),
            ),
            Obx(
              () => Column(
                children: [
                  Row(
                    children: [
                      Radio<int>(
                        fillColor:
                            WidgetStatePropertyAll(ColorConstant.primary500),
                        value: 1,
                        groupValue: notifController.selectedOption.value,
                        onChanged: (value) {
                          notifController.setSelectedOption(value!);
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Set this as default",
                        style: TextStyleConstant.subtitle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio<int>(
                        fillColor:
                            WidgetStatePropertyAll(ColorConstant.primary500),
                        value: 2,
                        groupValue: notifController.selectedOption.value,
                        onChanged: (value) {
                          notifController.setSelectedOption(value!);
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Just Once",
                        style: TextStyleConstant.subtitle,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                    child: ButtonWidget(
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
                  onTap: () {
                    while (Get.isBottomSheetOpen == true) {
                      Get.back();
                    }
                  },
                  buttonName: "Save",
                  boxDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorConstant.primary500,
                  ),
                  textStyle:
                      TextStyleConstant.subtitle.copyWith(color: Colors.white),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
