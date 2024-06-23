import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantopia/constants/color_constant.dart';

class CustomLoginGoogleWidget extends StatelessWidget {
  final void Function()? onPressed;
  final double? borderRadiusCircular;

  const CustomLoginGoogleWidget({
    super.key,
    this.onPressed,
    this.borderRadiusCircular,
  });

  @override
  Widget build(BuildContext context) {
    // final AuthController authController = Get.put(AuthController());

    return Column(
      children: [
        const SizedBox(
          height: 14.0,
        ),
        Center(
          child: Text(
            'Or',
            style: GoogleFonts.nunito(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9ba5b7)),
          ),
        ),
        const SizedBox(
          height: 14.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.white,
              splashFactory: InkRipple.splashFactory,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFF10B981)),
                borderRadius: BorderRadius.circular(borderRadiusCircular ?? 8),
              ),
              elevation: 0,
            ),
            onPressed: () {
              Get.snackbar(
                'Notice',
                'App Info coming soon',
                backgroundColor: ColorConstant.primary500,
                colorText: ColorConstant.neutral100,
                snackPosition: SnackPosition.BOTTOM,
                borderRadius: 16,
                margin: const EdgeInsets.all(16),
                borderWidth: 2,
                borderColor: ColorConstant.neutral100,
                isDismissible: true,
                duration: const Duration(seconds: 2),
                animationDuration: const Duration(milliseconds: 400),
                forwardAnimationCurve: Curves.fastOutSlowIn,
                reverseAnimationCurve: Curves.easeOut,
                icon: Icon(
                  Icons.info_outline,
                  color: ColorConstant.neutral0,
                ),
                shouldIconPulse: true,
              );
              // Get.toNamed(AppRoutes.authGoogle);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/Google.png'),
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  'Log In With Google',
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff10b981f)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
