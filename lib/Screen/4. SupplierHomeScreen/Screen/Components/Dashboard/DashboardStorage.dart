import 'package:flutter/material.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';
import '../../../../../Constants/Colors.dart';

class StorageDashboard extends StatelessWidget {
  const StorageDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        leading: const AppBarBackButtonPop(),
        title: const AppBarTitle(label: 'Storage'),
        centerTitle: true,
      ),
    );
  }
}