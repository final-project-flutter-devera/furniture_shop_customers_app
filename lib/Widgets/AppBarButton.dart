import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';

class AppBarBackButtonPop extends StatelessWidget {
  const AppBarBackButtonPop({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 24,
          color: AppColor.black,
        ));
  }
}

class AppBarButtonPush extends StatelessWidget {
  final Function() aimRoute;
  final dynamic icon;

  const AppBarButtonPush(
      {super.key, required this.aimRoute, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: aimRoute,
      icon: icon,
    );
  }
}

class AppBarButtonPushReplace extends StatelessWidget {
  final dynamic aimRoute;
  final dynamic icon;

  const AppBarButtonPushReplace({super.key, required this.aimRoute, this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => aimRoute));
      },
      icon: icon,
    );
  }
}
