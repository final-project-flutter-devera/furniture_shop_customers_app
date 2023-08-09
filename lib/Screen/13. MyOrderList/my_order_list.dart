import 'dart:math';

import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Objects/order.dart';
import 'package:furniture_shop/Screen/13.%20MyOrderList/Components/order_card.dart';
import 'package:furniture_shop/Widgets/bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

//TODO: Pass list of order to display
class MyOrderList extends StatefulWidget {
  const MyOrderList({super.key});

  @override
  State<MyOrderList> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrderList> {
  //Order will be sorted into List by delivery status
  //TODO: Replace random order generation
  late List<Order> delivered = List<Order>.generate(
      5,
      (index) => Order(
          number: Random().nextInt(10000000).toString(),
          date: DateTime(2023, Random().nextInt(13), Random().nextInt(29)),
          status: OrderStatus.delivered));
  late List<Order> processing = List<Order>.generate(
      5,
      (index) => Order(
          number: Random().nextInt(10000000).toString(),
          date: DateTime(2023, Random().nextInt(13), Random().nextInt(29)),
          status: OrderStatus.processing));
  late List<Order> canceled = List<Order>.generate(
      5,
      (index) => Order(
          number: Random().nextInt(10000000).toString(),
          date: DateTime(2023, Random().nextInt(13), Random().nextInt(29)),
          status: OrderStatus.canceled));
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          backgroundColor: AppColor.blur_grey,
          appBar: AppBar(
            backgroundColor: AppColor.blur_grey,
            foregroundColor: AppColor.black,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 40,
              ),
            ),
            title: const Text(
              'My order',
            ),
            titleTextStyle: AppStyle.app_bar_title_text_style,
            centerTitle: true,
            elevation: 0,
            bottom: TabBar(
                labelColor: AppColor.black,
                indicatorColor: AppColor.black,
                indicator: UnderlineTabIndicator(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    borderSide: const BorderSide(width: 3),
                    insets: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 10)),
                labelStyle: AppStyle.tab_title_text_style,
                unselectedLabelColor: AppColor.disabled_button,
                splashBorderRadius: BorderRadius.circular(10),
                tabs: const <Widget>[
                  Tab(
                    text: "Delivered",
                  ),
                  Tab(
                    text: 'Processing',
                  ),
                  Tab(
                    text: 'Cancelled',
                  ),
                ]),
          ),
          body: TabBarView(children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: delivered.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 25, left: 20, right: 20),
                        child: OrderCard(order: delivered[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: processing.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 25, left: 20, right: 20),
                        child: OrderCard(order: processing[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: canceled.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 25, left: 20, right: 20),
                        child: OrderCard(order: canceled[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ]),
          bottomNavigationBar: const AppBottomNavigationBar(),
        ));
  }
}
