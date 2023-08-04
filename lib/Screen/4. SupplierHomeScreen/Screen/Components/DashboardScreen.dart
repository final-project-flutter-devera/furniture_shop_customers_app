import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Screen/4.%20SupplierHomeScreen/Screen/Components/Dashboard/DashboardOrder.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../1. Boarding/BoardingScreen.dart';
import 'Dashboard/DashboardAnalytics.dart';
import 'Dashboard/DashboardBalance.dart';
import 'Dashboard/DashboardProfile.dart';
import 'Dashboard/DashboardStorage.dart';
import 'Dashboard/DashboardStore.dart';

List<String> label = [
  'Store',
  'Orders',
  'Profile',
  'Storage',
  'Balance',
  'analytics',
];

List<IconData> icons = [
  Icons.store,
  Icons.shopping_basket,
  Icons.account_circle,
  Icons.production_quantity_limits,
  Icons.account_balance_wallet,
  Icons.analytics,
];
List<Widget> pages = const [
  StoreDashboard(),
  OrderDashboard(),
  ProfileDashboard(),
  StorageDashboard(),
  BalanceDashboard(),
  AnalyticsDashboard(),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        title: const AppBarTitle(label: 'Dashboard'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          AppBarButtonPushReplace(
              aimRoute: const BoardingScreen(),
              icon: SvgPicture.asset('assets/Images/Icons/Logout.svg',
                  height: 24, width: 24)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          mainAxisSpacing: 30,
          crossAxisSpacing: 30,
          crossAxisCount: 2,
          children: List.generate(6, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => pages[index]));
              },
              child: Card(
                shadowColor: AppColor.grey,
                elevation: 50,
                color: AppColor.black.withOpacity(0.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      icons[index],
                      color: AppColor.white,
                      size: 60,
                    ),
                    Text(
                      label[index].toUpperCase(),
                      style: GoogleFonts.nunito(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
