import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/Images/Icons/search.svg',
                height: 20, width: 20)),
        title: Text('Notifications',
            style: GoogleFonts.merriweather(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black)),
        centerTitle: true,
      ),
    );
  }
}
