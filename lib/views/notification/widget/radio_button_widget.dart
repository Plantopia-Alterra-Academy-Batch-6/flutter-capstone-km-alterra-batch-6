import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/notification_controller.dart';

class RadioButtonWidget extends StatelessWidget {
  RadioButtonWidget({super.key});

  final NotificationController notifController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
