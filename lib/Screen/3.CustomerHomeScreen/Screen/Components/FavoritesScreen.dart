import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'SearchScreen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: SvgPicture.asset('assets/Images/Icons/search.svg',
                height: 20, width: 20)),
        title: Text(
          'Favorites',
          style: GoogleFonts.merriweather(
              fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/Images/Icons/cart.svg',
                  height: 20, width: 20)),
        ],
        centerTitle: true,
      ),
    );
  }
}
