import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Widgets/Label_Radio.dart';
import 'Check_Out_Screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key, required this.deliveryMethod});

  final String deliveryMethod;

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int selectValue = 1;
  late final String paymentMethod;

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
          'Payment Method',
          style: GoogleFonts.merriweather(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Column(
        children: [
          LabelRadio(
            icon: const Icon(FontAwesomeIcons.creditCard),
            value: 1,
            groupValue: selectValue,
            label: 'Credit / Debit Card',
            widget: const Row(
              children: [
                Icon(FontAwesomeIcons.ccApplePay),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.ccAmazonPay),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.ccMastercard),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.ccVisa),
              ],
            ),
            onChanged: (int? value) {
              setState(() {
                selectValue = value!;
              });
            },
          ),
          LabelRadio(
            icon: const Icon(FontAwesomeIcons.handHoldingDollar),
            value: 2,
            groupValue: selectValue,
            label: 'Cash On Delivery (COD)',
            widget: const Text(
                'COD fee: \$0, Discount shipping fee (if available) applicable include COD fee.'),
            onChanged: (int? value) {
              setState(() {
                selectValue = value!;
              });
            },
          ),

          // LabelRadio(
          //   icon: const Icon(FontAwesomeIcons.buildingColumns),
          //   value: 3,
          //   groupValue: selectValue,
          //   label: 'Bank Transfer',
          //   widget: const Row(
          //     children: [
          //       Icon(FontAwesomeIcons.moneyBillTransfer),
          //     ],
          //   ),
          //   onChanged: (int? value) {
          //     setState(() {
          //       selectValue = value!;
          //     });
          //   },
          // ),
          // LabelRadio(
          //   icon: const Icon(FontAwesomeIcons.wallet),
          //   value: 4,
          //   groupValue: selectValue,
          //   label: 'Pay via wallet',
          //   widget: const Row(
          //     children: [
          //       Icon(FontAwesomeIcons.applePay),
          //       SizedBox(width: 10),
          //       Icon(FontAwesomeIcons.googlePay),
          //       SizedBox(width: 10),
          //       Icon(FontAwesomeIcons.amazonPay),
          //     ],
          //   ),
          //   onChanged: (int? value) {
          //     setState(() {
          //       selectValue = value!;
          //     });
          //   },
          // ),
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
              if (selectValue == 2) {
                setState(() {
                  paymentMethod = 'Cash on Delivery - COD';
                });
              } else if (selectValue == 1) {
                setState(() {
                  paymentMethod = 'Credit / Debit Card';
                });
              }
              // else if (selectValue == 3) {
              //   setState(() {
              //     paymentMethod = 'Bank Transfer';
              //   });
              // } else if (selectValue == 4) {
              //   setState(() {
              //     paymentMethod = 'Payment via wallet';
              //   });
              // }
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckOutScreen(
                            paymentMethod: paymentMethod,
                            deliveryMethod: widget.deliveryMethod,
                          )));
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
