import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plantopia/constants/color_constant.dart';
import 'package:plantopia/constants/text_style_constant.dart';

class CustomDialogSuccess extends StatelessWidget {
  const CustomDialogSuccess({
    super.key,
    this.isOnLogin = false,
  });
  final bool isOnLogin;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorConstant.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/onboarding/success.svg'),
            Text("Yay!",
                style: TextStyleConstant.heading4.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                )),
            const SizedBox(
              height: 4.0,
            ),
            SizedBox(
              width: 250,
              child: Text(
                textAlign: TextAlign.center,
                'You’ve successfully ${isOnLogin ? 'log in' : 'signed up'}. Excited to grow with you! 🌿',
                style: TextStyleConstant.subtitle.copyWith(fontSize: 16),
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
