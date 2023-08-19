import 'package:flutter/material.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Providers/Cart_Provider.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/AppBarTitle.dart';
import 'package:google_fonts/google_fonts.dart';
import '../CustomerHomeScreen.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double wMQ = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: const AppBarBackButtonPop(),
        title: const AppBarTitle(label: 'Cart'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_forever_outlined,
              color: AppColor.black,
              size: 24,
            ),
          ),
        ],
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return ListView.builder(
              itemCount: cart.count,
              itemBuilder: (context, index) {
                final product = cart.getItems[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Card(
                      elevation: 3,
                      child: SizedBox(
                        height: 120,
                        width: 335,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: Image.network(
                                product.imageList.first,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: AppColor.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 80,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.attach_money,
                                                  size: 16,
                                                ),
                                                Text(
                                                  product.price
                                                      .toStringAsFixed(2),
                                                  style: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    color: AppColor.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 140,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        color: AppColor.grey5,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: product.quantity == 1
                                                        ? IconButton(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                              Icons
                                                                  .delete_forever,
                                                              size: 14,
                                                            ),
                                                          )
                                                        : IconButton(
                                                            onPressed: () {
                                                              cart.decrementByOne(
                                                                  product);
                                                            },
                                                            icon: const Icon(
                                                              Icons.remove,
                                                              size: 14,
                                                            ),
                                                          ),
                                                  ),
                                                  Text(
                                                    product.quantity.toString(),
                                                    style: product.quantity ==
                                                            product
                                                                .availableQuantity
                                                        ? GoogleFonts.nunito(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                AppColor.red)
                                                        : GoogleFonts.nunito(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                AppColor.black,
                                                          ),
                                                  ),
                                                  Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        color: AppColor.grey5,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8)),
                                                    child: IconButton(
                                                      onPressed: product
                                                                  .quantity ==
                                                              product
                                                                  .availableQuantity
                                                          ? null
                                                          : () {
                                                              cart.increment(
                                                                  product);
                                                            },
                                                      icon: const Icon(
                                                        Icons.add,
                                                        size: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.cancel_outlined,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),

      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Hey! Your cart is empty!',
      //         style: GoogleFonts.nunito(
      //           fontSize: 24,
      //           fontWeight: FontWeight.w700,
      //           color: AppColor.black,
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //       ClipRRect(
      //         borderRadius: BorderRadius.circular(20),
      //         child: MaterialButton(
      //           height: 50,
      //           minWidth: wMQ * 0.6,
      //           color: AppColor.black,
      //           onPressed: () {
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const CustomerHomeScreen(),
      //               ),
      //             );
      //           },
      //           child: Text(
      //             'Continue shopping',
      //             style: GoogleFonts.nunito(
      //               fontSize: 18,
      //               fontWeight: FontWeight.w400,
      //               color: AppColor.white,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total:',
              style: GoogleFonts.nunito(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black),
            ),
            Text(
              '\$ ',
              style: GoogleFonts.nunito(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: MaterialButton(
            height: 60,
            color: AppColor.black,
            onPressed: () {},
            child: Text(
              'Check Out',
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
