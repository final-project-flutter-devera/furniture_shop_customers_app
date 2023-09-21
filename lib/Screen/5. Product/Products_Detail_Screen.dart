import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:furniture_shop/Constants/Colors.dart';
import 'package:furniture_shop/Providers/Cart_Provider.dart';
import 'package:furniture_shop/Providers/Favorites_Provider.dart';
import 'package:furniture_shop/Screen/2.%20Login%20-%20Signup/Login.dart';
import 'package:furniture_shop/Widgets/AppBarButton.dart';
import 'package:furniture_shop/Widgets/MyMessageHandler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../Models/Product_model.dart';
import '../3.CustomerHomeScreen/Screen/Components/CartScreen.dart';
import '../3.CustomerHomeScreen/Screen/Components/home_screen/components/search_screen.dart';
import 'Full_Screen_View_Images.dart';
import 'Visit_Store.dart';
import 'package:collection/collection.dart';
import 'package:badges/badges.dart' as badges;
import 'package:furniture_shop/Providers/Product_class.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic products;

  const ProductDetailScreen({
    super.key,
    required this.products,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    context.read<Cart>().loadCartItemsProvider();
    context.read<Favorites>().loadWishItemsProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var onSale = widget.products['discount'];
    double wMQ = MediaQuery.of(context).size.width;
    double hMQ = MediaQuery.of(context).size.height;
    Stream<QuerySnapshot> productsStream() => FirebaseFirestore.instance
        .collection('products')
        .where('mainCategory', isEqualTo: widget.products['mainCategory'])
        .where('subCategory', isEqualTo: widget.products['subCategory'])
        .snapshots();
    final _productsStream = productsStream();
    Stream<QuerySnapshot> reviewStream() => FirebaseFirestore.instance
        .collection('products')
        .doc(widget.products['proID'])
        .collection('reviews')
        .snapshots();
    final _reviewStream = reviewStream();
    late List<dynamic> imagesList = widget.products['proImages'];
    CollectionReference suppliers =
        FirebaseFirestore.instance.collection('Suppliers');
    final String supplierID = widget.products['sid'];
    var existingFavorites = context
        .read<Favorites>()
        .getFavoriteItems
        .firstWhereOrNull(
            (product) => product.documentID == widget.products['proID']);
    var existCart = context.read<Cart>().getItems.firstWhereOrNull(
        (product) => product.documentID == widget.products['proID']);
    final _future = suppliers.doc(supplierID).get();
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
                        builder: (context) => const ProductSearch()));
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
              onPressed: FirebaseAuth.instance.currentUser!.isAnonymous
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    }
                  : () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartScreen()));
                    },
              icon: badges.Badge(
                showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
                badgeContent: Text(
                  context.watch<Cart>().getItems.length.toString(),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: AppColor.amber,
                ),
                badgeAnimation: const badges.BadgeAnimation.fade(),
                child: SvgPicture.asset('assets/Images/Icons/cart.svg'),
              ),
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
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.products['proName'],
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
                                Row(
                                  children: [
                                    onSale != 0
                                        ? Text(
                                            ((1 - (onSale / 100)) *
                                                    widget.products['price'])
                                                .toStringAsFixed(2),
                                            style: GoogleFonts.nunito(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          )
                                        : const Text(''),
                                    const SizedBox(width: 10),
                                    Text(
                                      widget.products['price']
                                          .toStringAsFixed(2),
                                      style: onSale != 0
                                          ? GoogleFonts.nunito(
                                              fontSize: 18,
                                              color: AppColor.red,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontWeight: FontWeight.w400,
                                            )
                                          : GoogleFonts.nunito(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        widget.products['inStock'] == 0
                            ? Text(
                                'Out of stock',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.red,
                                ),
                              )
                            : Text(
                                'In stock: ${widget.products['inStock']}',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.black,
                                ),
                              ),
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
                          onPressed: FirebaseAuth
                                  .instance.currentUser!.isAnonymous
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Login()));
                                }
                              : () {
                                  existingFavorites != null
                                      ? context
                                          .read<Favorites>()
                                          .removeThis(widget.products['proID'])
                                      : context
                                          .read<Favorites>()
                                          .addFavoriteItems(
                                            Product(
                                              name: widget.products['proName'],
                                              price: onSale != 0
                                                  ? ((1 - (onSale / 100)) *
                                                      widget.products['price'])
                                                  : widget.products['price'],
                                              quantity: 1,
                                              availableQuantity:
                                                  widget.products['inStock'],
                                              imageList: imagesList.first,
                                              documentID:
                                                  widget.products['proID'],
                                              supplierID:
                                                  widget.products['sid'],
                                            ),
                                          );
                                },
                          icon: context
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
                    const SizedBox(height: 10),
                    FutureBuilder<DocumentSnapshot>(
                      future: _future,
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
                              Flexible(
                                child: Row(
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
                                    Flexible(
                                      child: SizedBox(
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
                                    ),
                                  ],
                                ),
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
                        return const Scaffold(
                          backgroundColor: Colors.transparent,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    const TitleDivider(
                      label: '   Product detail   ',
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.products['prodesc'],
                      style: GoogleFonts.nunito(
                        color: AppColor.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ExpandableTheme(
                      data: const ExpandableThemeData(
                          iconColor: AppColor.black,
                          iconSize: 30,
                          tapBodyToCollapse: true,
                          tapBodyToExpand: true,
                          tapHeaderToExpand: true),
                      child: review(_reviewStream),
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
                        return StaggeredGridView.countBuilder(
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
                onTap: FirebaseAuth.instance.currentUser!.isAnonymous
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      }
                    : () {
                        existingFavorites != null
                            ? context
                                .read<Favorites>()
                                .removeThis(widget.products['proID'])
                            : context.read<Favorites>().addFavoriteItems(
                                  Product(
                                    name: widget.products['proName'],
                                    price: onSale != 0
                                        ? ((1 - (onSale / 100)) *
                                            widget.products['price'])
                                        : widget.products['price'],
                                    quantity: 1,
                                    availableQuantity:
                                        widget.products['inStock'],
                                    imageList: imagesList.first,
                                    documentID: widget.products['proID'],
                                    supplierID: widget.products['sid'],
                                  ),
                                );
                      },
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
                      child: context
                                  .watch<Favorites>()
                                  .getFavoriteItems
                                  .firstWhereOrNull((product) =>
                                      product.documentID ==
                                      widget.products['proID']) !=
                              null
                          ? const Icon(Icons.bookmark)
                          : const Icon(Icons.bookmark_border_outlined)),
                ),
              ),
              GestureDetector(
                onTap: FirebaseAuth.instance.currentUser!.isAnonymous
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      }
                    : () {},
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
                onTap: FirebaseAuth.instance.currentUser!.isAnonymous
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      }
                    : () {
                        if (widget.products['inStock'] == 0) {
                          MyMessageHandler.showSnackBar(
                              _scaffoldKey, 'This product out of stock');
                        } else if (existCart != null) {
                          MyMessageHandler.showSnackBar(_scaffoldKey,
                              'This product already in your cart!');
                        } else {
                          context.read<Cart>().addItems(
                                Product(
                                  name: widget.products['proName'],
                                  price: onSale != 0
                                      ? ((1 - (onSale / 100)) *
                                          widget.products['price'])
                                      : widget.products['price'],
                                  quantity: 1,
                                  availableQuantity: widget.products['inStock'],
                                  imageList: imagesList.first,
                                  documentID: widget.products['proID'],
                                  supplierID: widget.products['sid'],
                                ),
                              );
                        }
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
                      existCart != null ? 'Added to cart' : 'Add to cart',
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

Widget review(var reviewStream) {
  return ExpandablePanel(
    header: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 70,
            child: Divider(
              thickness: 1,
              color: AppColor.black,
            ),
          ),
          Text(
            '   review  ',
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
      ),
    ),
    collapsed: SizedBox(
      height: 230,
      child: reviewAll(reviewStream),
    ),
    expanded: reviewAll(reviewStream),
  );
}

Widget reviewAll(var reviewStream) {
  return StreamBuilder<QuerySnapshot>(
    stream: reviewStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot3) {
      if (snapshot3.hasError) {
        return const Text('Something went wrong');
      }

      if (snapshot3.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot3.data!.docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(snapshot3.data!.docs[index]['profileImages']),
                backgroundColor: AppColor.white,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(snapshot3.data!.docs[index]['name']),
                  Row(
                    children: [
                      Text(snapshot3.data!.docs[index]['rate'].toString()),
                      const Icon(
                        Icons.star,
                        color: AppColor.amber,
                      ),
                    ],
                  ),
                ],
              ),
              subtitle: Text(snapshot3.data!.docs[index]['comment']),
            );
          });
    },
  );
}
