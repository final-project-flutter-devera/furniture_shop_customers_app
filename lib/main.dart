import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:furniture_shop/Providers/Cart_Provider.dart';
import 'package:furniture_shop/Providers/Favorites_Provider.dart';
import 'package:furniture_shop/Providers/SQL_helper.dart';
import 'package:furniture_shop/Providers/customer_provider.dart';
import 'package:furniture_shop/Providers/supplier_provider.dart';
import 'package:furniture_shop/localization/localization_delegate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Providers/Stripe_ID.dart';
import 'Screen/1. Boarding/BoardingScreen.dart';
import 'Screen/2. Login - Signup/Login.dart';
import 'Screen/2. Login - Signup/Signup.dart';
import 'Screen/3.CustomerHomeScreen/Screen/CustomerHomeScreen.dart';
import 'firebase_options.dart';

late SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  SQLHelper.getDatabase;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]).then((value) => const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Favorites()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => SupplierProvider()),
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
        locale: Locale(Platform.localeName),
        localizationsDelegates: const <LocalizationsDelegate>[
          AppLocalizationDelegate(),
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale.fromSubtags(languageCode: 'vi'),
          Locale.fromSubtags(languageCode: 'en'),
        ],
        initialRoute: '/Welcome_boarding',
        routes: <String, WidgetBuilder>{
          '/Welcome_boarding': (BuildContext context) => const BoardingScreen(),
          '/Customer_screen': (BuildContext context) =>
              const CustomerHomeScreen(),
          '/Login_cus': (BuildContext context) => const Login(),
          '/Signup_cus': (BuildContext context) => const Signup(),
        });
  }
}
