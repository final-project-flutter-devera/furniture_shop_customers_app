import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Screen/1.%20Boarding/BoardingScreen.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';
import '../../../../Widgets/ShowAlertDialog.dart';
import 'SearchScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        leading: AppBarButtonPush(
          aimRoute: const SearchScreen(),
          icon: SvgPicture.asset(
            'assets/Images/Icons/search.svg',
            height: 24,
            width: 24,
          ),
        ),
        title: const AppBarTitle(label: 'Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/Images/Icons/Logout.svg',
                height: 24, width: 24),
            onPressed: () async {
              MyAlertDialog.showMyDialog(
                context: context,
                title: 'Log out',
                content: 'Are you sure log out?',
                tabNo: () {
                  Navigator.pop(context);
                },
                tabYes: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BoardingScreen(),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}


