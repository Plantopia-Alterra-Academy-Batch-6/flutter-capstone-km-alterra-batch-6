import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/notification_controller.dart';
import 'package:plantopia/views/notification/widget/bottom_sheet2_button_widget.dart';
import 'package:plantopia/views/notification/widget/radio_button_widget.dart';

class BottomSheet2Widget extends StatelessWidget {
  BottomSheet2Widget({super.key, required this.notifId});
  final int notifId;

  final NotificationController notifController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstant.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24))),
      width: double.infinity,
      height: 460,
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
                        style: TextStyleConstant.caption.copyWith(
                          color: ColorConstant.neutral500,
                        ),
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
                borderRadius: BorderRadius.circular(16),
              ),
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
                    minutesInterval: 60,
                    highlightedTextStyle: TextStyleConstant.heading3.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    spacing: 32,
                    itemHeight: 30,
                    itemWidth: 30,
                    onTimeChange: (time) {
                      notifController.dateTime.value = time;
                    },
                  ),
                ],
              ),
            ),
            RadioButtonWidget(),
            const SizedBox(
              height: 16,
            ),
            BottomSheet2ButtonWidget(notifId: notifId)
          ],
        ),
      ),
    );
  }
}
