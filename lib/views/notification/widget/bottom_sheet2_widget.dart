import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
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
                CachedNetworkImage(
                  imageUrl: notifController
                          .plantByIdResponse?.data?.plantImages?[0].fileName ??
                      "",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notifController.plantByIdResponse?.data?.name ?? "-",
                        style: TextStyleConstant.subtitle.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Default reminder : ${notifController.plantByIdResponse?.data?.wateringSchedule?.wateringTime ?? "-"}",
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
                    style: TextStyleConstant.paragraph
                        .copyWith(fontWeight: FontWeight.w700),
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
                    highlightedTextStyle: TextStyleConstant.heading3.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
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
                  RadioListTile(
                    title: Text(
                      "Set this as default",
                      style: TextStyleConstant.subtitle,
                    ),
                    fillColor: WidgetStatePropertyAll(ColorConstant.primary500),
                    value: true,
                    groupValue: notifController.selectedOption.value,
                    onChanged: (value) {
                      notifController.setSelectedOption(value!);
                    },
                  ),
                  RadioListTile(
                    title: Text(
                      "Just Once",
                      style: TextStyleConstant.subtitle,
                    ),
                    fillColor: WidgetStatePropertyAll(ColorConstant.primary500),
                    value: false,
                    groupValue: notifController.selectedOption.value,
                    onChanged: (value) {
                      notifController.setSelectedOption(value!);
                    },
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
                        'Watering will be reminded in 1 hour',
                        style: TextStyleConstant.paragraph.copyWith(
                          color: ColorConstant.white,
                        ),
                      ),
                      action: SnackBarAction(
                        label: '',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
