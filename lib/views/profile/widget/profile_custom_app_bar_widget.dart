import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/controllers/my_plant_controller.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class ProfileCustomAppBarWidget extends StatelessWidget {
  const ProfileCustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
    final MyPlantController myPlantController = Get.put(MyPlantController());

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Profile',
          style: TextStyleConstant.heading4.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: ColorConstant.primary400,
                ),
                child: Center(
                  child: Icon(
                    Icons.person,
                    color: ColorConstant.neutral0,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authController.currentUser.value?.name ?? '',
                    style: TextStyleConstant.title.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Obx(
                    () => Text(
                      '${myPlantController.listMyPlant.length} Plants Owned',
                      style: TextStyleConstant.subtitle.copyWith(color: ColorConstant.neutral500),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: SvgPicture.asset(
                  IconConstant.editPencil,
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  Get.snackbar(
                    'Notice',
                    'Edit profile coming soon',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
