import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAuthButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final double? borderRadiusCircular;
  final bool isActive;

  const CustomAuthButtonWidget({
    super.key,
    this.onPressed,
    required this.text,
    this.borderRadiusCircular,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusCircular ?? 8),
            ),
            elevation: 0,
            backgroundColor:
                isActive ? const Color(0xFF10B981) : const Color(0xFFF3F4F6)),
        onPressed: isActive ? onPressed : () {},
        child: Text(
          text,
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.w700,
              color: isActive ? Colors.white : const Color(0xFF9CA3AF)),
        ),
      ),
    );
  }
}
