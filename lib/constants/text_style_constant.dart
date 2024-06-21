import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantopia/constants/color_constant.dart';

class TextStyleConstant {
  static TextStyle superLarge = GoogleFonts.nunito(
    fontSize: 80,
    fontWeight: FontWeight.w600,
    color: const Color(0xFFFFFFFF),
  );

  static TextStyle heading1 = GoogleFonts.nunito(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: ColorConstant.neutral950,
  );

  static TextStyle heading2 = GoogleFonts.nunito(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: ColorConstant.neutral950,
  );

  static TextStyle heading3 = GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: ColorConstant.neutral950,
  );

  static TextStyle heading4 = GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: ColorConstant.neutral950,
  );

  static TextStyle title = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: ColorConstant.neutral950,
  );

  static TextStyle subtitle = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: ColorConstant.neutral950,
  );

  static TextStyle paragraph = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: ColorConstant.neutral950,
  );

  static TextStyle caption = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: ColorConstant.neutral950,
  );

  static TextStyle footer = GoogleFonts.nunito(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: ColorConstant.neutral950,
  );

  static TextStyle semiBold = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: const Color(0xFFFFFFFF),
  );
}
