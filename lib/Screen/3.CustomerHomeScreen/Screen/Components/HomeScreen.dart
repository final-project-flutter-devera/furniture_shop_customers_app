import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';

import '../../Body/Body_Customer_HomeScreen.dart';
import 'CartScreen.dart';
import 'SearchScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: const TabBarView(
          children: [
            Center(child: Text('Popular Screen')),
            Center(child: Text('Chair Screen')),
            Center(child: Text('Table Screen')),
            Center(child: Text('Armchair Screen')),
            Center(child: Text('Bed Screen')),
            Center(child: Text('Lamb Screen')),
          ],
        ),
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
          title: const TitleAppBar(),
          centerTitle: true,
          actions: [
            AppBarButtonPush(
              aimRoute: const CartScreen(),
              icon: SvgPicture.asset(
                'assets/Images/Icons/cart.svg',
                height: 24,
                width: 24,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(100, 100),
            child: SizedBox(
              height: 100,
              child: TabBar(
                indicatorColor: AppColor.black,
                isScrollable: true,
                tabs: [
                  HomeTabBar(
                    label: 'Popular',
                    icon: SvgPicture.asset('assets/Images/Icons/star.svg'),
                  ),
                  HomeTabBar(
                      label: 'Chair',
                      icon: SvgPicture.asset('assets/Images/Icons/chair.svg')),
                  HomeTabBar(
                      label: 'Table',
                      icon: SvgPicture.asset('assets/Images/Icons/table.svg')),
                  HomeTabBar(
                      label: 'Armchair',
                      icon: SvgPicture.asset('assets/Images/Icons/sofa.svg')),
                  HomeTabBar(
                      label: 'Bed',
                      icon: SvgPicture.asset('assets/Images/Icons/bed.svg')),
                  HomeTabBar(
                      label: 'Lamp',
                      icon: SvgPicture.asset('assets/Images/Icons/lamp.svg')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
