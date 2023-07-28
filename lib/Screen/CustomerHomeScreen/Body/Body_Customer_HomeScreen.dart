import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


//Title Home Screen

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Make home',
          style: GoogleFonts.gelasio(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
        Text(
          'BEAUTIFUL',
          style: GoogleFonts.gelasio(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}


//Custom Widget TabBar
class HomeTabBar extends StatelessWidget {
  final dynamic icon;
  final String label;

  const HomeTabBar({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Tab(
        child: Column(
          children: [
            Container(
              height: 44,
              width: 44,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(144, 144, 144, 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                height: 28,
                width: 28,
                child: icon,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
