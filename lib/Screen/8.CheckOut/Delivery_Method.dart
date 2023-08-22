import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/Label_Radio.dart';
import 'Check_Out_Screen.dart';

class DeliveryMethod extends StatefulWidget {
  const DeliveryMethod({super.key, required this.paymentMethod});
  final String paymentMethod;

  @override
  State<DeliveryMethod> createState() => _DeliveryMethodState();
}

class _DeliveryMethodState extends State<DeliveryMethod> {
  int selectValue = 1;
  late final String deliveryMethod;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        foregroundColor: AppColor.black,
        elevation: 0,
        leading: const AppBarBackButtonPop(),
        centerTitle: true,
        title: Text(
          'Delivery Method',
          style: GoogleFonts.merriweather(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          LabelRadio(
            icon: const Icon(FontAwesomeIcons.planeDeparture),
            value: 1,
            groupValue: selectValue,
            label: 'Super Fast - Delivery (1-2days)',
            widget: const Row(
              children: [
                Icon(FontAwesomeIcons.dhl),
                SizedBox(width: 10),
                Icon(FontAwesomeIcons.fedex),
                SizedBox(width: 10),
                Icon(FontAwesomeIcons.ups),
              ],
            ),
            onChanged: (int? value) {
              setState(() {
                selectValue = value!;
              });
            },
          ),
          LabelRadio(
            icon: const Icon(FontAwesomeIcons.truckFast),
            value: 2,
            groupValue: selectValue,
            label: 'Fast - Delivery (2-4days)',
            widget: const Row(
              children: [
                Icon(FontAwesomeIcons.dhl),
                SizedBox(width: 10),
                Icon(FontAwesomeIcons.fedex),
                SizedBox(width: 10),
                Icon(FontAwesomeIcons.ups),
              ],
            ),
            onChanged: (int? value) {
              setState(() {
                selectValue = value!;
              });
            },
          ),
          LabelRadio(
            icon: const Icon(FontAwesomeIcons.piggyBank),
            value: 3,
            groupValue: selectValue,
            label: 'Save - Delivery (Up to 7 days)',
            widget: const Row(
              children: [
                Icon(FontAwesomeIcons.dhl),
                SizedBox(width: 10),
                Icon(FontAwesomeIcons.fedex),
                SizedBox(width: 10),
                Icon(FontAwesomeIcons.ups),
              ],
            ),
            onChanged: (int? value) {
              setState(() {
                selectValue = value!;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: MaterialButton(
            height: 60,
            color: AppColor.black,
            onPressed: () {
              if (selectValue == 1) {
                setState(() {
                  deliveryMethod = 'Super Fast - Delivery (1-2days)';
                });
              } else if (selectValue == 2) {
                setState(() {
                  deliveryMethod = 'Fast - Delivery (2-4days)';
                });
              } else if (selectValue == 3) {
                setState(() {
                  deliveryMethod = 'Save - Delivery (Up to 7 days)';
                });
              }
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckOutScreen(
                        deliveryMethod: deliveryMethod,paymentMethod: widget.paymentMethod,)));
            },
            child: Text(
              'Confirm',
              style: GoogleFonts.nunito(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
