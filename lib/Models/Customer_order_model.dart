import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../Constants/Colors.dart';
import '../Widgets/ShowAlertDialog.dart';

class CustomerOrderModel extends StatelessWidget {
  final dynamic order;

  const CustomerOrderModel({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = order['cancelDate'];
    DateTime dateTime = timestamp.toDate();
    String dateOnly = DateFormat('dd/MM/yyyy - HH:mm').format(dateTime);

    return ExpansionTile(
      textColor: AppColor.black,
      title: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    order['orderImage'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['orderName'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('x' + order['orderQuantity'].toString()),
                            Text('\$ ' + order['orderPrice'].toStringAsFixed(2))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(color: AppColor.black),
                child: Center(
                  child: Text(
                    'Detail',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColor.white),
                  ),
                ),
              ),
            ),
            order['cancelStatus'] == true
                ? Text(
                    'Canceled',
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColor.red),
                  )
                : Text(
                    order['deliveryStatus'],
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.red),
                  ),
          ],
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              constraints:
                  BoxConstraints(minHeight: 0, maxHeight: double.infinity),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColor.grey5,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name:    ' + order['cusName'],
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Phone:    ' + order['phone'],
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Email:    ' + order['email'],
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Address:    ' + order['address'],
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: [
                        Text(
                          'Canceled date:    ',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '$dateOnly',
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColor.red),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Order status:    ',
                          style: GoogleFonts.nunito(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        order['cancelStatus'] == true
                            ? Text(
                                'Cancel',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.red,
                                ),
                              )
                            : Text(''),
                      ],
                    ),
                    order['deliveryStatus'] == 'Shipping'
                        ? Text(
                            'Estimated delivery date:    ' +
                                order['deliveryDate'],
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )
                        : Text(''),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        order['deliveryStatus'] == 'Delivered' &&
                                order['orderReview'] == false
                            ? MaterialButton(
                                onPressed: () {},
                                elevation: 1,
                                height: 30,
                                color: AppColor.amber,
                                textColor: AppColor.black,
                                child: Text('Review'),
                              )
                            : Text(''),
                        order['deliveryStatus'] == 'Delivered' &&
                                order['orderReview'] == true
                            ? Row(
                                children: [
                                  Icon(Icons.sticky_note_2),
                                  Text('Review Added')
                                ],
                              )
                            : Text(''),
                        order['cancelStatus'] == true
                            ? Text('')
                            : MaterialButton(
                                onPressed: () {
                                  MyAlertDialog.showMyDialog(
                                    context: context,
                                    title: 'Cancel Order',
                                    content: 'Are you sure?',
                                    tabNo: () {
                                      Navigator.pop(context);
                                    },
                                    tabYes: () {
                                      CollectionReference orderRef =
                                          FirebaseFirestore.instance
                                              .collection('orders');
                                      orderRef.doc(order['orderID']).update({
                                        'cancelDate': DateTime.now(),
                                        'cancelStatus': true,
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                elevation: 1,
                                height: 30,
                                color: AppColor.red,
                                textColor: AppColor.white,
                                child: Text('Cancel'),
                              )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
