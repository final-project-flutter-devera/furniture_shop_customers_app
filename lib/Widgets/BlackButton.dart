import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlackButton extends StatelessWidget {
  final String title;
  final Size size;
  BlackButton({super.key, required this.title, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
