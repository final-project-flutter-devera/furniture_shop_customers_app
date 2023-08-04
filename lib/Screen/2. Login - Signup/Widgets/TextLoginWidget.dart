import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextLoginSignup extends StatelessWidget {
  final String label;
  final String label2;
  const TextLoginSignup({
    super.key, required this.label, required this.label2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: label,
              style: GoogleFonts.merriweather(
                color: const Color(0xFF909090),
                fontSize: 30,
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            TextSpan(
              text: label2.toUpperCase(),
              style: GoogleFonts.merriweather(
                color: const Color(0xFF303030),
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 1.88,
                letterSpacing: 1.20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}