import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/icon_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';
import 'package:plantopia/controllers/profile_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/profile/widget/profile_custom_app_bar_widget.dart';
import '../../constants/image_constant.dart';
part 'widget/profile_button_logout_widget.dart';
part 'widget/profile_setting_item_widget.dart';
part 'widget/profile_account_widget.dart';
part 'widget/profile_help_and_support_widget.dart';
part 'widget/profile_about_the_app_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: ColorConstant.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileCustomAppBarWidget(),
              const ProfileAccountWidget(),
              const ProfileHelpAndSupportWidget(),
              const ProfileAboutTheAppWidget(),
              ProfileButtonLogoutWidget(profileController: profileController),
            ],
          ),
        ),
      ),
    );
  }
}
