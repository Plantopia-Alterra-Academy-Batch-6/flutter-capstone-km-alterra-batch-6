import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/onboarding/widgets/carousel_widget.dart';
import 'package:plantopia/views/onboarding/widgets/custom_button_onboarding_widget.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: ColorConstant.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/logo_plantopia.svg',
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                clipBehavior: Clip.antiAlias,
                                child: Image.asset(
                                  'assets/icons/american-flag.png',
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "EN",
                                style: GoogleFonts.nunito(
                                    color: const Color(0xFF030712),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const CarouselWidget(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButtonOnBoardingWidget(
                    text: "Log in",
                    backgroundColor: ColorConstant.primary100,
                    color: ColorConstant.primary500,
                    onPressed: () {
                      authController.authSection.value = 0;
                      Get.toNamed(AppRoutes.auth);
                    },
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  CustomButtonOnBoardingWidget(
                    text: "Sign Up",
                    backgroundColor: ColorConstant.primary500,
                    color: ColorConstant.white,
                    onPressed: () {
                      authController.authSection.value = 1;
                      Get.toNamed(AppRoutes.auth);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
