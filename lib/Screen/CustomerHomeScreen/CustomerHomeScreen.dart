import 'package:flutter/material.dart';
import 'package:furniture_shop/Screen/CustomerHomeScreen/HomeScreen.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreen();
}

class _CustomerHomeScreen extends State<CustomerHomeScreen> {
  int _selectIndex = 0;
  final List<Widget> _tabs = const [
    HomeScreen(),
    Center(child: Text('Favorites Screen')),
    Center(child: Text('Notations Screen')),
    Center(child: Text('Profile Screen')),
  ];

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
