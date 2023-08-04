import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constants/Colors.dart';

class AppBarTitle extends StatelessWidget {
  final String label;
  const AppBarTitle({super.key, required this.label});
  @override
  Widget build(BuildContext context) {
    return Text(
          label,
          style: GoogleFonts.merriweather(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
        );
  }
}
