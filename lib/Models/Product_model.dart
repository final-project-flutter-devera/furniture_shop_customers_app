import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../Constants/Colors.dart';
import '../Providers/Favorites_Provider.dart';
import '../Screen/2. Login - Signup/Login.dart';
import '../Screen/5. Product/Products_Detail_Screen.dart';

class ProductModel extends StatefulWidget {
  final dynamic products;

  const ProductModel({super.key, required this.products});

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    var onSale = widget.products['discount'];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                      proList: widget.products,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: 225,
                      width: 185,
                      child: Image(
                        image: NetworkImage(
                          widget.products['proImages'][0],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    widget.products['proName'],
                    style: GoogleFonts.nunito(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.attach_money,
                            size: 20,
                          ),
                          Row(
                            children: [
                              onSale != 0
                                  ? Text(
                                      ((1 - (onSale / 100)) *
                                              widget.products['price'])
                                          .toString(),
                                      style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : Text(''),
                              SizedBox(width: 5),
                              Text(
                                widget.products['price'].toStringAsFixed(2),
                                style: onSale != 0
                                    ? GoogleFonts.nunito(
                                        fontSize: 11,
                                        color: AppColor.red,
                                        decoration: TextDecoration.lineThrough,
                                      )
                                    : GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      widget.products['sid'] ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? GestureDetector(
                              onTap: () {},
                              child: const Icon(Icons.edit),
                            )
                          : GestureDetector(
                              onTap: FirebaseAuth
                                      .instance.currentUser!.isAnonymous
                                  ? () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Login()));
                                    }
                                  : () {
                                      context
                                                  .read<Favorites>()
                                                  .getFavoriteItems
                                                  .firstWhereOrNull((product) =>
                                                      product.documentID ==
                                                      widget
                                                          .products['proID']) !=
                                              null
                                          ? context
                                              .read<Favorites>()
                                              .removeThis(
                                                  widget.products['proID'])
                                          : context
                                              .read<Favorites>()
                                              .addFavoriteItems(
                                                widget.products['proName'],
                                                widget.products['price'],
                                                1,
                                                widget.products['inStock'],
                                                widget.products['proImages'],
                                                widget.products['proID'],
                                                widget.products['sid'],
                                              );
                                    },
                              child: context
                                          .watch<Favorites>()
                                          .getFavoriteItems
                                          .firstWhereOrNull((product) =>
                                              product.documentID ==
                                              widget.products['proID']) !=
                                      null
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border_outlined),
                            ),
                    ],
                  ),
                ],
              ),
            ),
            onSale != 0
                ? Positioned(
                    top: 17,
                    child: Container(
                      height: 25,
                      width: 90,
                      decoration: BoxDecoration(
                        color: AppColor.red,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Save ${onSale.toString()}%',
                          style: GoogleFonts.nunito(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColor.white),
                        ),
                      ),
                    ),
                  )
                : Container(color: Colors.transparent)
          ],
        ),
      ),
    );
  }
}
