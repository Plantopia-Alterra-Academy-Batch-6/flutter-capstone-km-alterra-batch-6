import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantopia/controllers/auth_controller.dart';

class CustomAuthAppbarWidget extends StatelessWidget {
  const CustomAuthAppbarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
            )),
        const SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Obx(() => authController.authSection.value == 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back',
                      style: GoogleFonts.nunito(
                          color: const Color(0xFF030712),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    Text(
                      "It's good to see you again!",
                      style: GoogleFonts.nunito(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, Plantopers!',
                      style: GoogleFonts.nunito(
                          color: const Color(0xFF030712),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 7.0,
                    ),
                    Text(
                      "Nice to meet you here! 🙌",
                      style: GoogleFonts.nunito(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )),
        ),
        const SizedBox(
          height: 24.0,
        ),
      ],
    );
  }
}
