import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Screen/CustomerHomeScreen/Body/Body_Customer_HomeScreen.dart';


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
            Center(
              child: Text(
                'Popular Screen',
              ),
            ),
            Center(
              child: Text(
                'Chair Screen',
              ),
            ),
            Center(
              child: Text(
                'Table Screen',
              ),
            ),
            Center(
              child: Text(
                'Armchair Screen',
              ),
            ),
            Center(
              child: Text(
                'Bed Screen',
              ),
            ),
            Center(
              child: Text(
                'Lamb Screen',
              ),
            ),
          ],
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: SvgPicture.asset('assets/Images/Icons/search.svg'),
            color: Colors.black,
            onPressed: () {},
          ),
          title: const TitleAppBar(),
          centerTitle: true,
          actions: [
            IconButton(
              color: Colors.black,
              onPressed: () {},
              icon: SvgPicture.asset('assets/Images/Icons/cart.svg'),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size(100, 100),
            child: SizedBox(
              height: 100,
              child: TabBar(
                labelColor: Colors.black,
                isScrollable: true,
                tabs: [
                  HomeTabBar(
                    label: 'Popular',
                    icon: SvgPicture.asset('assets/Images/Icons/star.svg'),
                  ),
                  HomeTabBar(
                    label: 'Chair',
                    icon: SvgPicture.asset('assets/Images/Icons/chair.svg'),
                  ),
                  HomeTabBar(
                    label: 'Table',
                    icon: SvgPicture.asset('assets/Images/Icons/table.svg'),
                  ),
                  HomeTabBar(
                    label: 'Armchair',
                    icon: SvgPicture.asset('assets/Images/Icons/sofa.svg'),
                  ),
                  HomeTabBar(
                    label: 'Bed',
                    icon: SvgPicture.asset('assets/Images/Icons/bed.svg'),
                  ),
                  HomeTabBar(
                    label: 'Lamp',
                    icon: SvgPicture.asset('assets/Images/Icons/lamp.svg'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

