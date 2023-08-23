import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Screen/13.%20MyOrderList/Components/order_card.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Canceled_Screen.dart';
import 'Delivered.dart';
import 'Processing_Screen.dart';

//TODO: Pass list of order to display
class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: TabBarView(
          children: [
            Processing(),
            Delivered(),
            Canceled(),
          ],
        ),
        appBar: AppBar(
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              size: 24,
            ),
          ),
          title: AppBarTitle(label: 'My Order'),
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
            labelColor: AppColor.black,
            indicatorColor: AppColor.black,
            unselectedLabelColor: AppColor.disabled_button,
            indicator: UnderlineTabIndicator(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: const BorderSide(width: 3),
                insets: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 10)),
            tabs: [
              Tab(
                  child: Text('Processing',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700, fontSize: 18))),
              Tab(
                  child: Text('Delivered',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700, fontSize: 18))),
              Tab(
                  child: Text('Canceled',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700, fontSize: 18))),
            ],
          ),
        ),
      ),
    );
  }
}
