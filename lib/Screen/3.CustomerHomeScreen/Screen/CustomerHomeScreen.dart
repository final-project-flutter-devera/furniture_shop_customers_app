import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Providers/Favorites_Provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Providers/Cart_Provider.dart';
import '../../../Services/Notification_Service.dart';
import 'Components/HomeScreen.dart';
import 'Components/ProfileScreen.dart';
import 'Components/FavoritesScreen.dart';
import 'Components/NotificationScreen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreen();
}

class _CustomerHomeScreen extends State<CustomerHomeScreen> {
  int _selectIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const FavoritesScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<Cart>().loadCartItemsProvider();
        context.read<Favorites>().loadWishItemsProvider();
      }
    });
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        NotificationService.displayNotification(message);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      snackBar: SnackBar(
        content: Text(
          "Tag again to exit !",
          style: GoogleFonts.nunito(color: AppColor.black),
        ),
        backgroundColor: AppColor.amber,
      ),
      child: Scaffold(
        body: _tabs[_selectIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          currentIndex: _selectIndex,
          elevation: 0,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectIndex = index;
            });
          },
        ),
      ),
    );
  }
}
