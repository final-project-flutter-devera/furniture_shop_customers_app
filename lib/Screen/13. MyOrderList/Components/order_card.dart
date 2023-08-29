// import 'package:flutter/material.dart';
// import 'package:furniture_shop/Constants/Colors.dart';
// import 'package:furniture_shop/Constants/style.dart';
// import 'package:furniture_shop/Objects/order.dart';
// import 'package:google_fonts/google_fonts.dart';

// class OrderCard extends StatelessWidget {
//   final Order order;
//   const OrderCard({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: AppStyle.white_container_decoration,
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 15, left: 21, right: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   //Order number
//                   Text(
//                     'Order No${order.amount}',
//                     style: GoogleFonts.nunitoSans(
//                         fontSize: 16,
//                         color: AppColor.black,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   Spacer(),
//                   Text(
//                     '${order.date.day.toString().length == 1 ? '0' : ''}${order.date.day}/${order.date.month.toString().length == 1 ? '0' : ''}${order.date.month}/${order.date.year}',
//                     style: GoogleFonts.nunitoSans(
//                         fontSize: 14, color: AppColor.text_secondary),
//                   ),
//                   //Order Date
//                 ],
//               ),
//             ),
//             const Padding(
//               padding: const EdgeInsets.only(top: 5, bottom: 10),
//               child: Divider(
//                 color: AppColor.blur_grey,
//                 thickness: 3,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 21, right: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 //TODO: List.length
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Quantity: ",
//                         style: GoogleFonts.nunitoSans(
//                             fontSize: 16, color: AppColor.text_secondary),
//                       ),
//                       Text(
//                         "03",
//                         style: GoogleFonts.nunitoSans(
//                             fontSize: 16,
//                             color: AppColor.black,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Total Amount: ",
//                         style: GoogleFonts.nunitoSans(
//                             fontSize: 16, color: AppColor.text_secondary),
//                       ),
//                       Text(
//                         '\$${order.totalPrice.toStringAsFixed(0)}',
//                         style: GoogleFonts.nunitoSans(
//                             fontSize: 16,
//                             color: AppColor.black,
//                             fontWeight: FontWeight.bold),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 30, bottom: 20, right: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 36,
//                     decoration: const BoxDecoration(
//                       color: AppColor.black,
//                       borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(5),
//                           bottomRight: Radius.circular(5)),
//                     ),
//                     child: TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           "Detail",
//                           style: GoogleFonts.nunito(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: AppColor.white),
//                         )),
//                   ),
//                   Spacer(),
//                   switch (order.status) {
//                     OrderStatus.canceled => Text(
//                         'Canceled',
//                         style: GoogleFonts.nunitoSans(
//                             fontSize: 16, color: AppColor.canceled),
//                       ),
//                     OrderStatus.delivered => Text(
//                         'Delivered',
//                         style: GoogleFonts.nunitoSans(
//                             fontSize: 16, color: AppColor.success),
//                       ),
//                     OrderStatus.processing => Text(
//                         'Processing',
//                         style: GoogleFonts.nunitoSans(
//                             fontSize: 16, color: AppColor.processing),
//                       ),
//                   },
//                 ],
//               ),
//             )
//           ]),
//     );
//   }
// }
