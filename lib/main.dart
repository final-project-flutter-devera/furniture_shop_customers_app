import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_shop/Screen/CustomerHomeScreen/CustomerHomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomerHomeScreen(),
    );
  }
}
