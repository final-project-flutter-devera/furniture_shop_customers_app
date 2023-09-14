import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Screen/13.%20MyOrderScreen/My_Order_Screen.dart';
import 'package:furniture_shop/Screen/3.CustomerHomeScreen/Screen/CustomerHomeScreen.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/MyMessageHandler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../Providers/Cart_Provider.dart';
import '../../Providers/Stripe_ID.dart';
import 'Delivery_Method.dart';
import 'Payment_Method_Screen.dart';
import 'Shipping_Address.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:http/http.dart' as http;

class CheckOutScreen extends StatefulWidget {
  late String? paymentMethod;
  late String? deliveryMethod;

  CheckOutScreen({super.key, this.paymentMethod, this.deliveryMethod});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('Customers');
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late String orderID;

  void showProgress() {
    ProgressDialog progressDialog = ProgressDialog(context: context);
    progressDialog.show(
        max: 100,
        msg: 'Please wait...',
        progressBgColor: AppColor.amber,
        progressValueColor: AppColor.black);
  }

  @override
  Widget build(BuildContext context) {
    var wMQ = MediaQuery.of(context).size.width;
    var hMQ = MediaQuery.of(context).size.height;
    double totalPrice = context.watch<Cart>().totalPrice;
    double totalPaid = context.watch<Cart>().totalPrice + 100.00;
    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ScaffoldMessenger(
            key: _scaffoldKey,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColor.white,
                foregroundColor: AppColor.black,
                elevation: 0,
                leading: const AppBarBackButtonPop(),
                centerTitle: true,
                title: Text(
                  'Check Out',
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleMethod(
                        label: 'Shipping Address',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ShippingAddress()));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: PhysicalModel(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.grey,
                          child: Container(
                            width: wMQ * 0.9,
                            height: 150,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data['name']}',
                                    style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    '${data['phone']}',
                                    style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: AppColor.grey),
                                  ),
                                  const SizedBox(height: 5),
                                  const Divider(
                                    height: 1,
                                    thickness: 2,
                                    color: AppColor.grey5,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '${data['address']}',
                                    style: GoogleFonts.nunito(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: AppColor.grey),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'List Products',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.grey,
                        ),
                      ),
                      Consumer<Cart>(
                        builder: (context, cart, child) {
                          return PhysicalModel(
                            color: AppColor.grey,
                            elevation: 2,
                            borderRadius: BorderRadius.circular(15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 100 * cart.count!.toDouble(),
                                width: wMQ,
                                decoration: const BoxDecoration(
                                  color: AppColor.white,
                                ),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cart.count,
                                  itemBuilder: (context, index) {
                                    final order = cart.getItems[index];
                                    return Container(
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            width: 1, color: AppColor.grey5),
                                      ),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: Image.network(order
                                                  .imageList
                                                  .toString()),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    order.name,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColor.grey,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '\$ ${order.price.toStringAsFixed(2)}',
                                                        style:
                                                            GoogleFonts.nunito(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: AppColor.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        ' x ${order.quantity.toString()}',
                                                        style:
                                                            GoogleFonts.nunito(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: AppColor.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TitleMethod(
                        label: 'Payment method',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentMethodScreen(
                                        deliveryMethod:
                                            widget.deliveryMethod.toString(),
                                      )));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: PhysicalModel(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.grey,
                          child: Container(
                            width: wMQ * 0.9,
                            height: 70,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  widget.paymentMethod != null &&
                                          widget.paymentMethod != 'null'
                                      ? Text(
                                          widget.paymentMethod.toString(),
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: AppColor.black),
                                        )
                                      : Text(
                                          'Select your payment method',
                                          style: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                              color: AppColor.red),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TitleMethod(
                        label: 'Delivery Method',
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DeliveryMethod(
                                        paymentMethod:
                                            widget.paymentMethod.toString(),
                                      )));
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: PhysicalModel(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.grey,
                          child: Container(
                            width: wMQ * 0.9,
                            height: 70,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  widget.deliveryMethod != null &&
                                          widget.deliveryMethod != 'null'
                                      ? Text(
                                          widget.deliveryMethod.toString(),
                                          style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: AppColor.black,
                                          ),
                                        )
                                      : Text(
                                          'Select your delivery method',
                                          style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color: AppColor.red,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Payment detail',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: PhysicalModel(
                          elevation: 2,
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.grey,
                          child: Container(
                            width: wMQ * 0.9,
                            height: 150,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  PaymentDetailWidget(
                                    label: 'Order:',
                                    number: totalPrice.toStringAsFixed(2),
                                  ),
                                  const PaymentDetailWidget(
                                    label: 'Delivery:',
                                    number: '100.00',
                                  ),
                                  PaymentDetailWidget(
                                    label: 'Total:',
                                    number: totalPaid.toStringAsFixed(2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: MaterialButton(
                    height: 60,
                    color: AppColor.black,
                    onPressed: () {
                      if (widget.paymentMethod == null ||
                          widget.paymentMethod == 'null') {
                        return MyMessageHandler.showSnackBar(
                            _scaffoldKey, 'Please select Payment method');
                      } else if (widget.deliveryMethod == null ||
                          widget.deliveryMethod == 'null') {
                        return MyMessageHandler.showSnackBar(
                            _scaffoldKey, 'Please select Delivery method');
                      } else if (widget.deliveryMethod != null ||
                          widget.deliveryMethod != 'null' &&
                              widget.paymentMethod != null ||
                          widget.paymentMethod != 'null') {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SizedBox(
                            height: hMQ * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 25),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Confirm Order',
                                        style: GoogleFonts.nunito(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.black,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total Paid:',
                                            style: GoogleFonts.nunito(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.black,
                                            ),
                                          ),
                                          Text(
                                            '\$ ${totalPaid.toStringAsFixed(2)}',
                                            style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Delivery method:',
                                            style: GoogleFonts.nunito(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.black,
                                            ),
                                          ),
                                          Text(
                                            widget.deliveryMethod.toString(),
                                            style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Payment method:',
                                            style: GoogleFonts.nunito(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.black,
                                            ),
                                          ),
                                          Text(
                                            widget.paymentMethod.toString(),
                                            style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40, bottom: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: MaterialButton(
                                        height: 60,
                                        color: AppColor.black,
                                        onPressed: () async {
                                          if (widget.paymentMethod ==
                                              'Credit / Debit Card') {
                                            int payment = totalPaid.round();
                                            int pay = payment * 100;
                                            makePayment(data, pay.toString());
                                          } else if (widget.paymentMethod ==
                                              'Cash on Delivery - COD') {
                                            showProgress();
                                            for (var item in context
                                                .read<Cart>()
                                                .getItems) {
                                              CollectionReference orderRef =
                                                  FirebaseFirestore.instance
                                                      .collection('orders');
                                              orderID = const Uuid().v4();
                                              await orderRef.doc(orderID).set({
                                                'cid': data['cid'],
                                                'cusName': data['name'],
                                                'email': data['email'],
                                                'address': data['address'],
                                                'phone': data['phone'],
                                                'profileImages':
                                                    data['profileimage'],
                                                'sid': item.supplierID,
                                                'proID': item.documentID,
                                                'orderID': orderID,
                                                'orderName': item.name,
                                                'orderImage':
                                                    item.imageList,
                                                'orderQuantity': item.quantity,
                                                'orderPrice':
                                                    item.quantity * item.price,
                                                'deliveryStatus': 'Preparing',
                                                'deliveryDate': '',
                                                'orderDate': DateTime.now(),
                                                'paymentStatus':
                                                    widget.paymentMethod,
                                                'cancelStatus': false,
                                                'cancelDate':
                                                    DateTime.timestamp(),
                                                'orderReview': false,
                                              }).whenComplete(() async {
                                                await FirebaseFirestore.instance
                                                    .runTransaction(
                                                        (transaction) async {
                                                  DocumentReference
                                                      documentReference =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              'products')
                                                          .doc(item.documentID);
                                                  DocumentSnapshot snapshoot2 =
                                                      await transaction.get(
                                                          documentReference);
                                                  transaction.update(
                                                      documentReference, {
                                                    'inStock':
                                                        snapshoot2['inStock'] -
                                                            item.quantity
                                                  });
                                                });
                                              });
                                              context
                                                  .read<Cart>()
                                                  .clearAllProduct();
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CustomerHomeScreen()),
                                                  (route) => route.isFirst);
                                            }
                                          }
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
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'Submit Order',
                      style: GoogleFonts.nunito(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Map<String, dynamic>? paymentIntentData;

  void makePayment(dynamic data, String total) async {
    paymentIntentData = await createPaymentInit(total);
    var GooglePay = const PaymentSheetGooglePay(
      merchantCountryCode: 'US',
      currencyCode: 'USD',
      testEnv: true,
    );
    var ApplePay = const PaymentSheetApplePay(
      merchantCountryCode: 'US',
    );
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        style: ThemeMode.system,
        merchantDisplayName: 'DevEra',
        googlePay: GooglePay,
        applePay: ApplePay,
        allowsDelayedPaymentMethods: true,
      ),
    );
    await displayPaymentSheet(data);
  }

  createPaymentInit(String total) async {
    try {
      Map<String, dynamic> body = {
        'amount': total,
        'currency': 'USD',
      };
      http.Response response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Content_Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  displayPaymentSheet(dynamic data) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        paymentIntentData = null;
        showProgress();
        for (var item in context.read<Cart>().getItems) {
          CollectionReference orderRef =
              FirebaseFirestore.instance.collection('orders');
          orderID = const Uuid().v4();
          await orderRef.doc(orderID).set({
            'cid': data['cid'],
            'cusName': data['name'],
            'email': data['email'],
            'address': data['address'],
            'phone': data['phone'],
            'profileImages': data['profileimage'],
            'sid': item.supplierID,
            'proID': item.documentID,
            'orderID': orderID,
            'orderName': item.name,
            'orderImage': item.imageList,
            'orderQuantity': item.quantity,
            'orderPrice': item.quantity * item.price,
            'deliveryStatus': 'Preparing',
            'deliveryDate': '',
            'orderDate': DateTime.now(),
            'paymentStatus': 'Paid online',
            'cancelStatus': false,
            'cancelDate': DateTime.timestamp(),
            'orderReview': false,
          }).whenComplete(() async {
            await FirebaseFirestore.instance
                .runTransaction((transaction) async {
              DocumentReference documentReference = FirebaseFirestore.instance
                  .collection('products')
                  .doc(item.documentID);
              DocumentSnapshot snapshoot2 =
                  await transaction.get(documentReference);
              transaction.update(documentReference,
                  {'inStock': snapshoot2['inStock'] - item.quantity});
            });
          });
          context.read<Cart>().clearAllProduct();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyOrderScreen()),
              (route) => route.isFirst);
        }
      });
      print('done');
    } catch (e) {
      print('failed');
    }
  }
}

class PaymentDetailWidget extends StatelessWidget {
  final String label;
  final String number;

  const PaymentDetailWidget({
    super.key,
    required this.label,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: AppColor.grey,
            ),
          ),
          Text(
            '\$ $number',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColor.black,
            ),
          ),
        ],
      ),
    );
  }
}

class TitleMethod extends StatelessWidget {
  final String label;
  final Function() onTap;

  const TitleMethod({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.grey,
          ),
        ),
        InkWell(
            onTap: onTap,
            child: SvgPicture.asset('assets/Images/Icons/edit.svg')),
      ],
    );
  }
}
