import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  //Used for product description, product name in homepage, shipping address
  static TextStyle secondary_text_style = GoogleFonts.nunito(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF808080));

  //Used for texts inside black container
  static TextStyle text_style_on_black_button = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
