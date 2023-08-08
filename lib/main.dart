import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screen/1. Boarding/BoardingScreen.dart';
import 'Screen/2. Login - Signup/Login.dart';
import 'Screen/2. Login - Signup/LoginSupplier.dart';
import 'Screen/2. Login - Signup/Signup.dart';
import 'Screen/3.CustomerHomeScreen/Screen/CustomerHomeScreen.dart';
import 'Screen/4. SupplierHomeScreen/Screen/SupplierHomeScreen.dart';

void main() async {
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) => const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: BoardingScreen(),
        initialRoute: '/Welcome_boarding',
        routes: {
          '/Welcome_boarding': (context) => const BoardingScreen(),
          '/Customer_screen': (context) => const CustomerHomeScreen(),
          '/Supplier_screen': (context) => const SupplierHomeScreen(),
          '/Login_cus': (context) => const Login(),
          '/Login_sup': (context) => const LoginSupplier(),
          '/Signup_cus': (context) => const Signup(),
        });
  }
}
