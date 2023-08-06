import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});
  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBar();
}

class _AppBottomNavigationBar extends State<AppBottomNavigationBar> {
  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColor.white,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
      currentIndex: _selectIndex,
      elevation: 10,
      selectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "",
        ),
      ],
      onTap: (index) {
        setState(() {
          _selectIndex = index;
        });
      },
    );
  }
}
