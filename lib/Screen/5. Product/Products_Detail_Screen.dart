import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Providers/Cart_Provider.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/MyMessageHandler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../Models/Product_model.dart';
import '../3.CustomerHomeScreen/Screen/Components/CartScreen.dart';
import '../3.CustomerHomeScreen/Screen/Components/SearchScreen.dart';
import 'Full_Screen_View_Images.dart';
import 'Visit_Store.dart';
import 'package:collection/collection.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic proList;

  const ProductDetailScreen({
    super.key,
    required this.proList,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    double wMQ = MediaQuery.of(context).size.width;
    double hMQ = MediaQuery.of(context).size.height;
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('mainCategory', isEqualTo: widget.proList['mainCategory'])
        .where('subCategory', isEqualTo: widget.proList['subCategory'])
        .snapshots();
    late List<dynamic> imagesList = widget.proList['proImages'];
    CollectionReference customers =
        FirebaseFirestore.instance.collection('customers');
    final String supplierID = widget.proList['sid'];
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.white,
          foregroundColor: AppColor.black,
          leading: const AppBarBackButtonPop(),
          title: Container(
            width: wMQ * 0.7,
            height: 35,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.grey5,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    'assets/Images/Icons/search.svg',
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'search',
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColor.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartScreen()));
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: wMQ,
                height: hMQ * 0.6,
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullScreenViewImages(
                                imagesList: imagesList,
                              ),
                            ),
                          );
                        },
                        child: PhysicalModel(
                          elevation: 2,
                          color: AppColor.black,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(60)),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                            ),
                            child: SizedBox(
                              width: wMQ * 0.85,
                              height: hMQ * 0.6,
                              child: Swiper(
                                pagination: const SwiperPagination(
                                  builder: SwiperPagination.dots,
                                ),
                                itemBuilder: (context, index) {
                                  return Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      imagesList[index],
                                    ),
                                  );
                                },
                                itemCount: imagesList.length,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.proList['proName'],
                      style: GoogleFonts.gelasio(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.attach_money,
                                  size: 39,
                                ),
                                Text(
                                  widget.proList['price'].toStringAsFixed(2),
                                  style: GoogleFonts.nunito(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text('In stock: ${widget.proList['inStock']}'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: wMQ * 0.41,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColor.amber,
                                size: 24,
                              ),
                              Text('5.0'),
                              Text('(110 reviews)'),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<DocumentSnapshot>(
                      future: customers.doc(supplierID).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong");
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return const Text("Document does not exist");
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 38,
                                    backgroundColor: AppColor.black,
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundColor: AppColor.white,
                                      backgroundImage: NetworkImage(
                                        data['profileimage'],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: wMQ * 0.4,
                                    child: Text(
                                      data['name'],
                                      style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.grey,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VisitStore(
                                        supplierID: supplierID,
                                      ),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: 90,
                                  height: 35,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        width: 2, color: AppColor.black),
                                  ),
                                  child: const Center(child: Text('Visit')),
                                ),
                              ),
                            ],
                          );
                        }
                        return const Scaffold();
                      },
                    ),
                    const SizedBox(height: 10),
                    const TitleDivider(
                      label: '   Product detail   ',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.proList['prodesc'],
                      style: GoogleFonts.nunito(
                        color: AppColor.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TitleDivider(
                      label: '  Similar product  ',
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: _productsStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Scaffold();
                        }
                        return SizedBox(
                          child: StaggeredGridView.countBuilder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              return ProductModel(
                                products: snapshot.data!.docs[index],
                              );
                            },
                            staggeredTileBuilder: (context) =>
                                const StaggeredTile.fit(1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {},
                child: PhysicalModel(
                  elevation: 1,
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(18),
                    decoration: ShapeDecoration(
                      color: AppColor.grey5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(Icons.bookmark_border_outlined),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: PhysicalModel(
                  elevation: 1,
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 60,
                    height: 60,
                    padding: const EdgeInsets.all(18),
                    decoration: ShapeDecoration(
                      color: AppColor.grey5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Icon(
                      Icons.textsms_outlined,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<Cart>().getItems.firstWhereOrNull((product) =>
                              product.documentID == widget.proList['proID']) !=
                          null
                      ? MyMessageHandler.showSnackBar(
                          _scaffoldKey, 'This product already in your cart!')
                      : context.read<Cart>().addItems(
                            widget.proList['proName'],
                            widget.proList['price'],
                            1,
                            widget.proList['inStock'],
                            widget.proList['proImages'],
                            widget.proList['proID'],
                            widget.proList['sid'],
                          );
                },
                child: PhysicalModel(
                  elevation: 1,
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 220,
                    height: 60,
                    padding: const EdgeInsets.all(18),
                    decoration: ShapeDecoration(
                      color: AppColor.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      'Add to cart',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
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
}

class TitleDivider extends StatelessWidget {
  final String label;

  const TitleDivider({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            thickness: 1,
            color: AppColor.black,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.gelasio(
            fontSize: 24,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            thickness: 1,
            color: AppColor.black,
          ),
        ),
      ],
    );
  }
}
