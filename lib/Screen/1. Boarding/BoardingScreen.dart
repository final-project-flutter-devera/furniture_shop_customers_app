import 'package:flutter/material.dart';
import 'package:furniture_shop/localization/app_localization.dart';
import 'package:google_fonts/google_fonts.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  @override
  Widget build(BuildContext context) {
    double wMQ = MediaQuery.of(context).size.width;
    double hMQ = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: wMQ,
        height: hMQ,
        decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.centerRight,
                image: AssetImage('assets/Images/Images/boarding.png'),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(
              left: wMQ * 0.1,
              top: hMQ * 0.28,
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(context.localize('boarding_title_1'),
                          style: GoogleFonts.gelasio(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF606060),
                              letterSpacing: 1.2)),
                    ],
                  )),
            ),
            Positioned(
              left: wMQ * 0.1,
              top: hMQ * 0.35,
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(context.localize('boarding_title_2'),
                      style: GoogleFonts.gelasio(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF303030)))),
            ),
            Positioned(
              left: wMQ * 0.2,
              top: hMQ * 0.45,
              child: Container(
                height: 105,
                width: 286,
                alignment: Alignment.centerLeft,
                child: Text(
                  context.localize('boarding_description'),
                  style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF808080)),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Positioned(
              top: hMQ * 0.8,
              left: wMQ * 0.3,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/Login_cus');
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 54,
                  width: 159,
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 54,
                        width: 159,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF232323),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          shadows: const [
                            BoxShadow(
                                color: Color(0x4C303030),
                                blurRadius: 30,
                                offset: Offset(0, 8),
                                spreadRadius: 0)
                          ],
                        ),
                      ),
                      Center(
                        child: Text(context.localize('label_get_started'),
                            style: GoogleFonts.gelasio(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
