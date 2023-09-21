import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Screen/3.CustomerHomeScreen/Screen/Components/home_screen/components/product_search_delegate.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:provider/provider.dart';
import '../../../../../Providers/Cart_Provider.dart';
import '../../../../2. Login - Signup/Login.dart';
import '../../../../Gallery/Gallery_armchair.dart';
import '../../../../Gallery/Gallery_bed.dart';
import '../../../../Gallery/Gallery_chair.dart';
import '../../../../Gallery/Gallery_lamp.dart';
import '../../../../Gallery/Gallery_popular.dart';
import '../../../../Gallery/Gallery_table.dart';
import '../../../Body/Body_Customer_HomeScreen.dart';
import '../CartScreen.dart';
import 'components/search_screen.dart';
import 'package:badges/badges.dart' as badges;

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
        backgroundColor: AppColor.white,
        body: const TabBarView(
          children: [
            GalleryPopular(),
            GalleryChair(),
            GalleryTable(),
            GalleryArmchair(),
            GalleryBed(),
            GalleryLamp(),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          leading: AppBarButtonPush(
            aimRoute: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductSearch()));
            },
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
              aimRoute: FirebaseAuth.instance.currentUser!.isAnonymous
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    }
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartScreen()));
                    },
              icon: badges.Badge(
                showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
                badgeContent: Text(
                  context.watch<Cart>().getItems.length.toString(),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: AppColor.amber,
                ),
                badgeAnimation: const badges.BadgeAnimation.fade(),
                child: SvgPicture.asset(
                  'assets/Images/Icons/cart.svg',
                  height: 24,
                  width: 24,
                ),
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
