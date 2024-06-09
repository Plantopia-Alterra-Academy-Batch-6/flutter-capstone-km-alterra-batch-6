// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:plantopia/helpers/user_token_preference.dart';
import 'package:plantopia/utils/app_routes.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserId().then((value) async {
        await Future.delayed(const Duration(seconds: 3));
        if (value != null) {
          Get.offNamed(AppRoutes.allowNotif);
        } else {
          Get.offNamed(AppRoutes.onboarding);
        }
      });
    });

    super.initState();
  }

  Future<String?> getUserId() async {
    String? userId = await UserTokenPref.getToken();
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SvgPicture.asset('assets/icons/logo_splashscreen.svg'),
    ));
  }
}
