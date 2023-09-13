import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Constants/style.dart';
import 'package:furniture_shop/Screen/16.%20ProfileRoutes/MyShippingAddress/Components/my_shipping_address_card.dart';
import 'package:furniture_shop/Screen/16.%20ProfileRoutes/MyShippingAddress/add_shipping_address.dart';
import 'package:furniture_shop/localization/app_localization.dart';

class MyShippingAddress extends StatefulWidget {
  @override
  State<MyShippingAddress> createState() => _MyShippingAddressState();
}

class _MyShippingAddressState extends State<MyShippingAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blur_grey,
        foregroundColor: AppColor.black,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 40,
          ),
        ),
        centerTitle: true,
        title: Text(
          context.localize('shipping_address_app_bar_title'),
          style: AppStyle.app_bar_title_text_style,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddShippingAddress()),
          );
        },
        child: const Icon(
          Icons.add,
          size: 24,
        ),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          child: MyShippingAddressCard(),
        ),
      ),
    );
  }
}
