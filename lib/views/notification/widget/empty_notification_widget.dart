import 'package:flutter/material.dart';
import 'package:plantopia/constants/image_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class EmptyNotificationWidget extends StatelessWidget {
  const EmptyNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(flex: 1, child: SizedBox()),
        Image.asset(ImageConstant.emptyNotification),
        Text(
          "No Notifications Yet",
          style: TextStyleConstant.title,
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Text(
            "As you start using the app, we’ll keep you updated here. Enjoy exploring!",
            style: TextStyleConstant.subtitle,
            textAlign: TextAlign.center,
          ),
        ),
        const Expanded(flex: 2, child: SizedBox())
      ],
    );
  }
}
