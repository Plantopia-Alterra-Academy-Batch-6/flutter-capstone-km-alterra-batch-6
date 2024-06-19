import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/utils/app_routes.dart';

class CustomAppbarForgotPasswordWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomAppbarForgotPasswordWidget(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20.0,
        ),
        IconButton(
            onPressed: () {
              Get.offNamed(AppRoutes.auth);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
            )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Text(title,
                  style: TextStyleConstant.heading3
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 7.0,
              ),
              Text(
                subtitle,
                style: TextStyleConstant.paragraph.copyWith(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
