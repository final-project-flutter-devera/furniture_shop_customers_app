import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';
import 'SearchScreen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: AppBarButtonPush(
          aimRoute: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const SearchScreen()));
          },
          icon: SvgPicture.asset(
            'assets/Images/Icons/search.svg',
            height: 24,
            width: 24,
          ),
        ),
        title: const AppBarTitle(label: 'Notifications'),
        centerTitle: true,
      ),
    );
  }
}
