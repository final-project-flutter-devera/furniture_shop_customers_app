import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
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
    color: AppColor.white,
  );
  //Used for texts inside white container
  static TextStyle text_style_on_white_button = GoogleFonts.nunito(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );
  //Used for text in TabBar and Profile Tab
  static TextStyle tab_title_text_style = GoogleFonts.nunitoSans(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColor.black,
  );
  static const List<BoxShadow> white_container_shadow_on_white_background = [
    BoxShadow(color: Color.fromRGBO(138, 149, 158, 0.2), blurRadius: 15)
  ];
  static Decoration white_container_decoration = BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(5),
      boxShadow: AppStyle.white_container_shadow_on_white_background);

  //Used for title in AppBar across screens
  static TextStyle app_bar_title_text_style = GoogleFonts.merriweather(
    color: AppColor.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle date_text_style = GoogleFonts.nunitoSans(
    fontSize: 12,
    color: AppColor.text_secondary,
  );
}
