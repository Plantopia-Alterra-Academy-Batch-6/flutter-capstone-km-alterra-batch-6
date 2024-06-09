import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

    return SizedBox(
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
        onPressed: () {},
        // onPressed: () => authController.signInWithGoogle(),
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
                  fontWeight: FontWeight.w700, color: const Color(0xff10b981f)),
            ),
          ],
        ),
      ),
    );
  }
}
