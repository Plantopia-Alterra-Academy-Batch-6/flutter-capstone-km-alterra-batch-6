import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantopia/controllers/auth_controller.dart';
import 'package:plantopia/utils/app_routes.dart';
import 'package:plantopia/views/onboarding/widgets/carousel_widget.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50.0,
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
                  Container(
                    child: const CarouselWidget(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 0,
                        backgroundColor: const Color(0xFFD1FAE5),
                      ),
                      onPressed: () {
                        authController.authSection.value = 0;
                        Get.toNamed(AppRoutes.auth);
                      },
                      child: Text(
                        'Log in',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 0,
                        backgroundColor: const Color(0xFF10B981),
                      ),
                      onPressed: () async {
                        authController.authSection.value = 1;

                        Get.toNamed(AppRoutes.auth);
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
