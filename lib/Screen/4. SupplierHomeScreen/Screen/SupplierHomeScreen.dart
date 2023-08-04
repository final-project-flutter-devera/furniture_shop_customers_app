import 'package:flutter/material.dart';
import '../../3.CustomerHomeScreen/Screen/Components/HomeScreen.dart';
import '../../3.CustomerHomeScreen/Screen/Components/NotificationScreen.dart';
import 'Components/DashboardScreen.dart';
import 'Components/UploadScreen.dart';

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() => _CustomerHomeScreen();
}

class _CustomerHomeScreen extends State<SupplierHomeScreen> {
  int _selectIndex = 0;
  final List<Widget> _tabs = const [
    HomeScreen(),
    NotificationScreen(),
    DashboardScreen(),
    UploadScreen(),
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
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
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
