import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_shop/Providers/Cart_Provider.dart';
import 'package:provider/provider.dart';
import 'Screen/1. Boarding/BoardingScreen.dart';
import 'Screen/2. Login - Signup/Login.dart';
import 'Screen/2. Login - Signup/LoginSupplier.dart';
import 'Screen/2. Login - Signup/Signup.dart';
import 'Screen/3.CustomerHomeScreen/Screen/CustomerHomeScreen.dart';
import 'Screen/4. SupplierHomeScreen/Screen/SupplierHomeScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  ).then((value) => const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
