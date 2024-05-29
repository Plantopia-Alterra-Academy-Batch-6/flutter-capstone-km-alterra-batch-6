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
  );
  static TextStyle semiBold = GoogleFonts.nunito(
    fontSize: 16,
  );
  static TextStyle regular = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle italic = GoogleFonts.nunito(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
}