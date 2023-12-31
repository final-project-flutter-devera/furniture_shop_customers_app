import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_shop/Providers/Favorites_Provider.dart';
import '../../../Providers/Cart_Provider.dart';
import '../../2. Login - Signup/Login.dart';
import 'Components/home_screen/HomeScreen.dart';
import 'Components/ProfileScreen.dart';
import 'Components/FavoritesScreen.dart';
import 'Components/NotificationScreen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreen();
}

class _CustomerHomeScreen extends State<CustomerHomeScreen> {
  static var isAnonymous = FirebaseAuth.instance.currentUser!.isAnonymous;
  int _selectIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const FavoritesScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
  @override
  void initState() {
    context.read<Cart>().loadCartItemsProvider();
    context.read<Favorites>().loadWishItemsProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
