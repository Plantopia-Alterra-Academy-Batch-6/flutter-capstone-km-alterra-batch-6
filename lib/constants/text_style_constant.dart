import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyleConstant {
  static TextStyle boldText = GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
   static TextStyle mediumText = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFFFFFFF),
  );
  static TextStyle semiBold = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static TextStyle regular = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: const Color(0xFFFFFFFF),

  );
  static TextStyle italic = GoogleFonts.nunito(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
  static TextStyle titleLarge = GoogleFonts.nunito(
    fontSize: 80,
    fontWeight: FontWeight.w600,
    color: const Color(0xFFFFFFFF),
  );
  static TextStyle heading1Bold = GoogleFonts.nunito(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF000000),
  );
  static TextStyle heading4Bold = GoogleFonts.nunito(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF000000),
  );
  static TextStyle bodySmall = GoogleFonts.nunito(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xFF000000),
  );
  static TextStyle paragraphBold = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: const Color(0xFF000000),
  );
}